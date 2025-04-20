import 'package:factoryio_app/all_imports.dart';
import 'package:factoryio_app/screens/chart_page.dart';

final countProvider = StateProvider<int>((ref) => 0);

class BoxCount extends ConsumerWidget {
  const BoxCount({super.key, this.color, this.textColor});

  final Color? color;
  final Color? textColor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap:
          () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return const Chart();
              },
            ),
          ),
      child: Card(
        margin: const EdgeInsets.all(16.0),
        color: color ?? Theme.of(context).colorScheme.surfaceContainerHighest,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Total boxes produced",
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: textColor ?? Colors.black87,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SmallBigBoxNumber(BoxType.big, color: textColor),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SmallBigBoxNumber(BoxType.small, color: textColor),
              ),
            ),
            BoxesNumber(color: textColor),
          ],
        ),
      ),
    );
  }
}

class BoxesNumber extends ConsumerWidget {
  const BoxesNumber({super.key, this.color});

  final Color? color;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(mqttProvider);
    int count = 0;
    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (provider.hasValue) {
      count = provider.value?[0] ?? 0;
    }

    return Text(
      count.toString(),
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 96.0,
        fontWeight: FontWeight.bold,
        color: color ?? Colors.black87,
      ),
    );
  }
}
