import 'package:factoryio_app/all_imports.dart';

enum BoxType { small, big }

class SmallBigBoxNumber extends ConsumerWidget {
  const SmallBigBoxNumber(this.type, {super.key, this.color});

  final BoxType type;
  final Color? color;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(mqttProvider);
    final text =
        type == BoxType.small ? "Total small boxes:" : "Total big boxes:";
    int count = 0;
    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (provider.hasValue && type == BoxType.small) {
      count = provider.value?[2] ?? 0;
    } else if (provider.hasValue && type == BoxType.big) {
      count = provider.value?[1] ?? 0;
    }

    return Text(
      '$text $count',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 12.0,
        fontWeight: FontWeight.bold,
        color: color ?? Colors.black87,
      ),
    );
  }
}
