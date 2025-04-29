import 'package:factoryio_app/all_imports.dart';

class ChartPage extends ConsumerWidget {
  const ChartPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(mqttProvider);
    final isLoading = state.isLoading;
    if (isLoading) {
      return const CircularProgressIndicator();
    }

    final total = (state.value?[0] ?? 0).toDouble();

    if (total == 0) {
      return const WidgetTotalZero();
    }
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    final isMobile = PlatformType.isMobile;
    final radius =
        isPortrait && isMobile
            ? MediaQuery.of(context).size.width * 0.5 - 76
            : MediaQuery.of(context).size.height * 0.5 - 126;

    final small = (state.value?[2] ?? 0).toDouble();
    final big = (state.value?[1] ?? 0).toDouble();

    final percSmall = ((small / total) * 100).round();
    final percBig = ((big / total) * 100).round();
    final smaller = radius - 20;
    final bigger = radius - 10;

    return Scaffold(
      appBar: AppBar(
        title: const Text(chartPageTitle),
        centerTitle: isPortrait ? false : true,
        actions:
            isPortrait && PlatformType.isMobile
                ? [DailyGoalAction()]
                : PlatformType.isDesktop
                ? [DailyGoalAction()]
                : null,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton.filledTonal(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      ),

      body: SafeArea(
        child: ParentOrientation(
          children: [
            Expanded(child: GoalGauge(total: total, radius: radius + 15)),
            Expanded(
              child: BodyTotalNonZero(
                radius: radius,
                total: total,
                big: big,
                small: small,
                smaller: smaller,
                bigger: bigger,
                percBig: percBig,
                percSmall: percSmall,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DailyGoalAction extends ConsumerWidget {
  const DailyGoalAction({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: IconButton.filledTonal(
        icon: const Icon(Icons.numbers),
        onPressed: () {
          DialogsHelper.setDailyGoalDialog(context).then((value) {
            if (value != null) {
              ref.read(dailyGoalProvider.notifier).setDailyGoal(value);
              ref
                  .read(mqttProvider.notifier)
                  .publishInt(Topics.topicDailyGoal.name, value);
            }
          });
        },
      ),
    );
  }
}

class GoalGauge extends ConsumerStatefulWidget {
  const GoalGauge({super.key, required this.total, required this.radius});

  final double total;
  final double radius;

  @override
  ConsumerState<GoalGauge> createState() => _GoalGaugeState();
}

class _GoalGaugeState extends ConsumerState<GoalGauge> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(dailyGoalProvider);

    final isLoading = state.isLoading;
    if (isLoading) {
      return const CircularProgressIndicator();
    }

    final dailyGoal =
        (state.hasValue && state.value != null ? state.value![0] : 100);

    return Stack(
      alignment: Alignment.center,
      children: [
        AnimatedScale(
          duration: const Duration(milliseconds: 300),
          scale: 1,
          curve: Curves.easeInOutBack,
          child: AnimatedRadialGauge(
            builder:
                (context, child, value) => Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    "${value.round()} / $dailyGoal",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                ),
            duration: const Duration(milliseconds: 1000),
            value: widget.total,
            curve: Curves.easeInOutBack,
            radius: widget.radius,
            axis: GaugeAxis(
              min: 0,
              max: dailyGoal.toDouble(),

              degrees: 270,

              style: GaugeAxisStyle(
                thickness: 20,
                background: Theme.of(context).colorScheme.secondaryContainer,
                segmentSpacing: 4,
              ),

              pointer: GaugePointer.needle(
                width: 16,
                height: widget.radius,
                borderRadius: 16,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),

              progressBar: GaugeProgressBar.rounded(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Text(
            "Goal",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ],
    );
  }
}

class BodyTotalNonZero extends StatelessWidget {
  const BodyTotalNonZero({
    super.key,
    required this.radius,
    required this.total,
    required this.big,
    required this.small,
    required this.smaller,
    required this.bigger,
    required this.percBig,
    required this.percSmall,
  });

  final double radius;
  final double total;
  final double big;
  final double small;
  final double smaller;
  final double bigger;
  final int percBig;
  final int percSmall;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        PieChart(
          PieChartData(
            startDegreeOffset: 0,
            centerSpaceRadius: 10,
            sections: [
              PieChartSectionData(
                radius: radius,
                titlePositionPercentageOffset: 0.55,
                value: total,
                color: Theme.of(context).colorScheme.primary,
                title: 'Total boxes\n${total.round()}',
                titleStyle: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              PieChartSectionData(
                radius: big < small ? smaller : bigger,
                titlePositionPercentageOffset: 0.65,
                value: big,
                color: Theme.of(context).colorScheme.secondary,
                title: 'High\n${big.toInt()} - $percBig%',

                titleStyle: TextStyle(
                  color: Theme.of(context).colorScheme.onSecondary,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              PieChartSectionData(
                radius: small < big ? smaller : bigger,
                titlePositionPercentageOffset: 0.65,
                value: small,
                color: Theme.of(context).colorScheme.tertiary,
                title: 'Low\n${small.toInt()} - $percSmall%',
                titleStyle: TextStyle(
                  color: Theme.of(context).colorScheme.onTertiary,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          duration: Duration(milliseconds: 150), // Optional
          curve: Curves.linear, // Optional
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Text(
            "Stats",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ],
    );
  }
}

class WidgetTotalZero extends ConsumerWidget {
  const WidgetTotalZero({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(dailyGoalProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chart"),
        actions: [DailyGoalAction()],
        leading: IconButton.filledTonal(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Center(
        child: Text(
          "Daily goal ${state.value?[0]}",
          style: TextStyle(fontSize: 26),
        ),
      ),
    );
  }
}
