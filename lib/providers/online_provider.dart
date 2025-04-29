import 'package:factoryio_app/all_imports.dart';

class OnlineNotifier extends AsyncNotifier<List<bool>> {
  @override
  Future<List<bool>> build() async {
    return [false, false];
  }

  Future<void> setStatus(bool appOnline, bool plcOnline) async {
    state = const AsyncValue.loading();
    state = AsyncValue.data([appOnline, plcOnline]);
  }
}

final onlineProvider = AsyncNotifierProvider<OnlineNotifier, List<bool>>(() {
  return OnlineNotifier();
});
