import 'package:factoryio_app/all_imports.dart';
import 'package:factoryio_app/providers/online_provider.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  Color? backgroundColor;
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
    final state = ref.watch(backgroundColorProvider);

    if (state.hasValue) {
      backgroundColor = ColorResolver.getColor(state.value, context);
    }

    return Scaffold(
      backgroundColor: backgroundColor,

      appBar: AppBar(
        title: TextWidget(
          text: homePageTitle,
          backgroundColor: backgroundColor ?? Colors.transparent,
        ),
        backgroundColor: backgroundColor,
        actions: [
          if (PlatformType.isDesktop)
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
        child: Stack(children: [HomePageBody(), StatusBar()]),
      ),
    );
  }
}

class StatusBar extends ConsumerWidget {
  const StatusBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(onlineProvider);
    bool appOnline = state.hasValue ? state.value![0] : false;
    bool plcOnline = state.hasValue ? state.value![1] : false;
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        width: double.maxFinite,
        child: BottomAppBar(
          height: PlatformType.isMobile ? 60 : null,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            spacing: 16,
            children: [
              Chip(
                avatar: Icon(
                  Icons.circle,
                  color: appOnline ? Colors.green : Colors.red,
                  size: PlatformType.isMobile ? 10 : null,
                ),
                label: Text(
                  "App",
                  style: TextStyle(
                    color: appOnline ? Colors.green : Colors.red,
                    fontSize: PlatformType.isMobile ? 10 : null,
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  child: Text(
                    "Connection\nstatus",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontSize: PlatformType.isMobile ? 10 : null,
                    ),
                  ),
                ),
              ),
              Chip(
                avatar: Icon(
                  Icons.circle,
                  color: plcOnline ? Colors.green : Colors.red,
                  size: PlatformType.isMobile ? 10 : null,
                ),
                label: Text(
                  "PLC",
                  style: TextStyle(
                    color: plcOnline ? Colors.green : Colors.red,
                    fontSize: PlatformType.isMobile ? 10 : null,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
