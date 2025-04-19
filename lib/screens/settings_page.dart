import 'package:factoryio_app/all_imports.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = Theme.of(context).colorScheme.surfaceContainerHighest;
    return Scaffold(
      backgroundColor: color,
      appBar: AppBar(title: const Text('Settings'), backgroundColor: color),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(children: [SettingsBody()]),
      ),
    );
  }
}
