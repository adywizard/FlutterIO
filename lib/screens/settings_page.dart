import 'package:factoryio_app/all_imports.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(backgroundColorProvider);
    Color? backgroundColor;
    if (state.hasValue) {
      backgroundColor = ColorResolver.getColor(state.value, context);
    }
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: TextWidget(
          text: settingsPageTitle,
          backgroundColor: backgroundColor ?? Colors.transparent,
        ),
        backgroundColor: backgroundColor,
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: [
            SettingsBody(
              backgroundColor: backgroundColor ?? Colors.transparent,
            ),
          ],
        ),
      ),
    );
  }
}
