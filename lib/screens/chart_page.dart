import 'package:factoryio_app/all_imports.dart';

class Chart extends ConsumerWidget {
  const Chart({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(mqttProvider).isLoading;
    if (isLoading) {
      return const CircularProgressIndicator();
    }

    final state = ref.watch(mqttProvider);
    final total = (state.value?[0] ?? 0).toDouble();

    if (total == 0) {
      return const WidgetTotalZero();
    }

    final radius = MediaQuery.of(context).size.width * 0.5;
    final small = (state.value?[2] ?? 0).toDouble();
    final big = (state.value?[1] ?? 0).toDouble();

    final percSmall = ((small / total) * 100).round();
    final percBig = ((big / total) * 100).round();
    final smaller = radius - 40;
    final bigger = radius - 35;

    return Scaffold(
      appBar: AppBar(title: const Text("Chart")),
      body: BodyTotalNonZero(
        radius: radius,
        total: total,
        big: big,
        small: small,
        smaller: smaller,
        bigger: bigger,
        percBig: percBig,
        percSmall: percSmall,
      ),
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
    return Center(
      child: PieChart(
        PieChartData(
          startDegreeOffset: 0,
          centerSpaceRadius: 10,
          sections: [
            PieChartSectionData(
              radius: radius - 30,
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
    );
  }
}

class WidgetTotalZero extends StatelessWidget {
  const WidgetTotalZero({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Chart")),
      body: Center(child: const Text("No data available")),
    );
  }
}
