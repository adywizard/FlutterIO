import 'package:factoryio_app/all_imports.dart';

class MainApp extends ConsumerStatefulWidget {
  const MainApp({super.key});

  @override
  ConsumerState<MainApp> createState() => _MainAppState();
}

class _MainAppState extends ConsumerState<MainApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.paused:
        ref
            .read(mqttProvider.notifier)
            .publish(Topics.diconnectedTopic.name, true);
        break;
      case AppLifecycleState.detached:
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (lightDynamic, darkDynamic) {
        final lightColorScheme =
            lightDynamic ??
            ColorScheme.fromSeed(
              seedColor: const Color(0xFF6750A4),
              brightness: Brightness.light,
              surfaceContainerHighest: const Color(0xFFFBFBFE),
            ).harmonized();
        final darkColorScheme =
            darkDynamic ??
            ColorScheme.fromSeed(
              seedColor: const Color(0xFF6750A4),
              brightness: Brightness.dark,
              surfaceContainerHighest: const Color(0xFF1C1B1F),
            ).harmonized();
        return MaterialApp(
          theme: ThemeData(
            colorScheme: lightColorScheme,
            fontFamily: GoogleFonts.montserrat().fontFamily,
          ),
          darkTheme: ThemeData(
            colorScheme: darkColorScheme,
            fontFamily: GoogleFonts.montserrat().fontFamily,
          ),
          home: HomePage(),
        );
      },
    );
  }
}
