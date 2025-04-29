import 'package:factoryio_app/all_imports.dart';

class BackgroundColorNotifier extends AsyncNotifier<String?> {
  @override
  Future<String?> build() async {
    final prefs = await SharedPreferences.getInstance();
    final color = prefs.getString('backgroundColor');
    return color;
  }

  Future<void> setColor(String color) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final prefs = await SharedPreferences.getInstance();

      await prefs.setString('backgroundColor', color);
      return color;
    });
  }
}

final backgroundColorProvider =
    AsyncNotifierProvider<BackgroundColorNotifier, String?>(() {
      return BackgroundColorNotifier();
    });
