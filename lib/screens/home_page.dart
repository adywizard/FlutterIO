import 'package:factoryio_app/all_imports.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ref.read(mqttProvider.notifier).setContext(context);
  }

  void _onRefresh(BuildContext context) {
    ref.read(mqttProvider.notifier).disconnect();
    Future.delayed(Durations.medium2, () {
      ref.invalidate(mqttProvider);
      if (context.mounted) {
        ref.read(mqttProvider.notifier).setContext(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.surfaceContainerHighest;
    return Scaffold(
      backgroundColor: color,
      appBar: AppBar(
        title: const Text(title),
        backgroundColor: color,
        actions: [
          if (Platform.isWindows || Platform.isLinux || Platform.isMacOS)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton.filledTonal(
                onPressed: () => _onRefresh(context),
                icon: Icon(Icons.refresh),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton.filledTonal(
              onPressed:
                  () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const SettingsPage(),
                    ),
                  ),
              icon: Icon(Icons.settings),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _onRefresh(context);
        },
        child: Stack(children: [HomePageBody()]),
      ),
    );
  }
}
