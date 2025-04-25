import 'package:factoryio_app/all_imports.dart';

class DailyGoalNotifier extends AsyncNotifier<int> {
  @override
  Future<int> build() async {
    final prefs = await SharedPreferences.getInstance();
    final dailyGoal = prefs.getInt('dailyGoal');
    return dailyGoal ?? 100;
  }

  Future<void> setDailyGoal(int dailyGoal) async {
    state = const AsyncValue.loading();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('dailyGoal', dailyGoal);
    state = AsyncValue.data(dailyGoal);
  }
}

final dailyGoalProvider = AsyncNotifierProvider<DailyGoalNotifier, int>(() {
  return DailyGoalNotifier();
});
