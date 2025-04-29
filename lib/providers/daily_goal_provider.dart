import 'package:factoryio_app/all_imports.dart';

class DailyGoalNotifier extends AsyncNotifier<List<int>> {
  int dailyGoal = 0;
  @override
  Future<List<int>> build() async {
    final prefs = await SharedPreferences.getInstance();
    dailyGoal = prefs.getInt('dailyGoal') ?? 100;
    return [dailyGoal];
  }

  Future<void> setDailyGoal(int newDAilyGoal) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('dailyGoal', newDAilyGoal);
    state = AsyncValue.data([newDAilyGoal]);
  }
}

final dailyGoalProvider = AsyncNotifierProvider<DailyGoalNotifier, List<int>>(
  () {
    return DailyGoalNotifier();
  },
);
