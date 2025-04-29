import 'package:factoryio_app/providers/background_color_provider.dart';
import 'package:factoryio_app/providers/settings_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum SettingsType {
  backgroundColor(name: 'Background color'),
  brokerAddress(name: 'Broker address'),
  brokerPort(name: 'Broker port'),
  brokerUsername(name: 'Username'),
  brokerPassword(name: 'Password'),
  brokerRootCert(name: 'Root certificate'),
  brokerDeviceCert(name: 'Device certificate'),
  brokerPrivateKey(name: 'Private key');

  const SettingsType({required this.name});
  final String name;
}

enum SettingsProviderType {
  backgroundColorProviderType(name: 'Background color provider'),
  brokerUsernameProviderType(name: 'Broker username provider'),
  brokerPasswordProviderType(name: 'Broker password provider'),
  brokerAddressProviderType(name: 'Broker address provider'),
  brokerPortProviderType(name: 'Broker port provider'),
  rootCertProviderType(name: 'Root certificate provider'),
  deviceCertProviderType(name: 'Device certificate provider'),
  privateKeyProviderType(name: 'Private key provider');

  const SettingsProviderType({required this.name});
  final String name;

  T getProvider<T extends AsyncNotifierProvider<Object?, Object?>>() {
    switch (this) {
      case SettingsProviderType.brokerUsernameProviderType:
        return brokerUsernameProvider as T;
      case SettingsProviderType.brokerPasswordProviderType:
        return brokerPasswordProvider as T;
      case SettingsProviderType.brokerAddressProviderType:
        return brokerAddressProvider as T;
      case SettingsProviderType.brokerPortProviderType:
        return brokerPortProvider as T;
      case SettingsProviderType.rootCertProviderType:
        return rootCertProvider as T;
      case SettingsProviderType.deviceCertProviderType:
        return deviceCertProvider as T;
      case SettingsProviderType.privateKeyProviderType:
        return privateKeyProvider as T;
      case SettingsProviderType.backgroundColorProviderType:
        return backgroundColorProvider as T;
    }
  }
}
