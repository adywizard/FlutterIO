import 'package:factoryio_app/all_imports.dart';

class MqttButton extends ConsumerWidget {
  final BoxDecoration? decoration;
  final TextStyle? style;
  final String topic;
  final String? label;
  final Color? color;
  final Color? boxShadowColor;
  final double? dx, dy, blurRadius, spreadRadius, borderRadius;
  const MqttButton({
    super.key,
    this.color,
    this.label,
    required this.topic,
    this.decoration,
    this.style,
    this.dx,
    this.dy,
    this.blurRadius,
    this.spreadRadius,
    this.borderRadius,
    this.boxShadowColor,
  });

  static publish(BuildContext context, String topic, value, WidgetRef ref) {
    final published = ref.read(mqttProvider.notifier).publish(topic, value);
    if (!published) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(topic),
            content: Text(
              "Could not publish to: $topic because app is not connected",
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("OK"),
              ),
            ],
          );
        },
      );
      return;
    }
    HapticFeedback.vibrate();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(mqttProvider);
    // final shadowColor = Colors.black;
    bool isPressed = false;
    if (state.isLoading) {
      return ColoredBox(
        color: Theme.of(context).colorScheme.secondaryContainer,
        child: const Center(child: CircularProgressIndicator()),
      );
    }
    return StatefulBuilder(
      builder:
          (context, setState) => GestureDetector(
            onLongPress: () {
              publish(context, topic, true, ref);
              setState(() {
                isPressed = true;
              });
            },
            onLongPressUp: () {
              publish(context, topic, false, ref);
              setState(() {
                isPressed = false;
              });
            },

            child: Card(
              color: color ?? Theme.of(context).colorScheme.primary,
              surfaceTintColor:
                  isPressed
                      ? Theme.of(context).colorScheme.primaryContainer
                      : Theme.of(context).colorScheme.primary,
              clipBehavior: Clip.antiAlias,
              elevation: isPressed ? 0 : 1,
              shadowColor:
                  isPressed
                      ? Colors.transparent
                      : boxShadowColor ?? Theme.of(context).colorScheme.shadow,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    label ?? "",
                    style: style,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
    );
  }
}
