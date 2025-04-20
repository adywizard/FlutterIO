import 'package:factoryio_app/all_imports.dart';

class Chart extends ConsumerWidget {
  const Chart({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final radius = MediaQuery.of(context).size.width * 0.25;
    final small = (ref.watch(mqttProvider).value?[2] ?? 0).toDouble();
    final big = (ref.watch(mqttProvider).value?[1] ?? 0).toDouble();
    final total = (ref.watch(mqttProvider).value?[0] ?? 0).toDouble();
    final percSmall = ((small / total) * 100).toInt();
    final percBig = ((big / total) * 100).toInt();
    final smaller = radius + 15;
    final bigger = radius + 25;
    return Scaffold(
      appBar: AppBar(title: const Text("Chart")),
      body: Center(
        child:
            ref.watch(mqttProvider).isLoading
                ? const CircularProgressIndicator()
                : PieChart(
                  PieChartData(
                    startDegreeOffset: -15,
                    centerSpaceRadius: 10,
                    sections: [
                      PieChartSectionData(
                        radius: radius + 40,
                        titlePositionPercentageOffset: 0.55,
                        value: total,
                        color: Theme.of(context).colorScheme.primary,
                        title: 'Total boxes\n${total.toInt()}',
                        titleStyle: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      PieChartSectionData(
                        radius: big < small ? smaller : bigger,
                        titlePositionPercentageOffset: 0.55,
                        value: big,
                        color: Theme.of(context).colorScheme.secondary,
                        title: 'Big boxes\n$percBig%',
                        titleStyle: TextStyle(
                          color: Theme.of(context).colorScheme.onSecondary,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      PieChartSectionData(
                        radius: small < big ? smaller : bigger,
                        titlePositionPercentageOffset: 0.55,
                        value: small,
                        color: Theme.of(context).colorScheme.tertiary,
                        title: 'Small boxes\n$percSmall%',
                        titleStyle: TextStyle(
                          color: Theme.of(context).colorScheme.onTertiary,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  duration: Duration(milliseconds: 150), // Optional
                  curve: Curves.linear, // Optional
                ),
      ),
    );
  }
}
