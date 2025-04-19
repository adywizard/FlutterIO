// Providers for storing settings
import 'package:factoryio_app/all_imports.dart';

final rootCertProvider = AsyncNotifierProvider<RootCertNotifier, String>(() {
  return RootCertNotifier();
});

class RootCertNotifier extends AsyncNotifier<String> {
  @override
  Future<String> build() async {
    final prefs = await SharedPreferences.getInstance();
    final filePath = prefs.getString('rootCertPath');
    return filePath ?? noFilePath;
  }

  Future<void> setFilePath(String path) async {
    state = const AsyncValue.loading();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('rootCertPath', path);
    state = AsyncValue.data(path);
  }
}

final deviceCertProvider = AsyncNotifierProvider<DeviceCertNotifier, String>(
  () {
    return DeviceCertNotifier();
  },
);

class DeviceCertNotifier extends AsyncNotifier<String> {
  @override
  Future<String> build() async {
    final prefs = await SharedPreferences.getInstance();
    final filePath = prefs.getString('deviceCertPath');
    return filePath ?? noFilePath;
  }

  Future<void> setFilePath(String path) async {
    state = const AsyncValue.loading();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('deviceCertPath', path);
    state = AsyncValue.data(path);
  }
}

final privateKeyProvider = AsyncNotifierProvider<PrivateKeyNotifier, String>(
  () {
    return PrivateKeyNotifier();
  },
);

class PrivateKeyNotifier extends AsyncNotifier<String> {
  @override
  Future<String> build() async {
    final prefs = await SharedPreferences.getInstance();
    final filePath = prefs.getString('privateKeyPath');
    return filePath ?? noFilePath;
  }

  Future<void> setFilePath(String path) async {
    state = const AsyncValue.loading();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('privateKeyPath', path);
    state = AsyncValue.data(path);
  }
}

final brokerAddressProvider =
    AsyncNotifierProvider<BrokerAddressNotifier, String>(() {
      return BrokerAddressNotifier();
    });

class BrokerAddressNotifier extends AsyncNotifier<String> {
  @override
  Future<String> build() async {
    final prefs = await SharedPreferences.getInstance();
    final address = prefs.getString('brokerAddress');
    return address ?? defaultBrokerAddress;
  }

  Future<void> setAddress(String address) async {
    state = const AsyncValue.loading();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('brokerAddress', address);
    state = AsyncValue.data(address);
  }
}

final brokerPortProvider = AsyncNotifierProvider<BrokerPortNotifier, int>(() {
  return BrokerPortNotifier();
});

class BrokerPortNotifier extends AsyncNotifier<int> {
  @override
  Future<int> build() async {
    final prefs = await SharedPreferences.getInstance();
    final port = prefs.getInt('brokerPort');
    return port ?? defaultPort;
  }

  Future<void> setPort(int port) async {
    state = const AsyncValue.loading();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('brokerPort', port);
    state = AsyncValue.data(port);
  }
}

final brokerUsernameProvider =
    AsyncNotifierProvider<BrokerUsernameNotifier, String>(() {
      return BrokerUsernameNotifier();
    });

class BrokerUsernameNotifier extends AsyncNotifier<String> {
  @override
  Future<String> build() async {
    final prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('brokerUsername');
    return username ?? defaultUsername;
  }

  Future<void> setUsername(String username) async {
    state = const AsyncValue.loading();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('brokerUsername', username);
    state = AsyncValue.data(username);
  }
}

final brokerPasswordProvider =
    AsyncNotifierProvider<BrokerPasswordNotifier, String>(() {
      return BrokerPasswordNotifier();
    });

class BrokerPasswordNotifier extends AsyncNotifier<String> {
  @override
  Future<String> build() async {
    final prefs = await SharedPreferences.getInstance();
    final password = prefs.getString('brokerPassword');
    return password ?? defaultPassword;
  }

  Future<void> setPassword(String password) async {
    state = const AsyncValue.loading();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('brokerPassword', password);
    state = AsyncValue.data(password);
  }
}
