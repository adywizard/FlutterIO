import 'package:factoryio_app/all_imports.dart';

class SettingsBody extends ConsumerWidget {
  const SettingsBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: ListView(
        children: [
          const Text(
            'User',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Divider(),
          SettingsTile(
            type: SettingsType.brokerUsername,
            providerType: SettingsProviderType.brokerUsernameProviderType,
          ),

          SettingsTile(
            type: SettingsType.brokerPassword,
            providerType: SettingsProviderType.brokerPasswordProviderType,
          ),
          Divider(),
          const SizedBox(height: 20),
          const Text(
            'Broker',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Divider(),
          SettingsTile(
            type: SettingsType.brokerAddress,
            providerType: SettingsProviderType.brokerAddressProviderType,
          ),

          SettingsTile(
            type: SettingsType.brokerPort,
            providerType: SettingsProviderType.brokerPortProviderType,
          ),
          Divider(),
          SizedBox(height: 20),
          const Text(
            'Certificates',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Divider(),
          SettingsTile(
            type: SettingsType.brokerRootCert,
            providerType: SettingsProviderType.rootCertProviderType,
          ),

          SettingsTile(
            type: SettingsType.brokerDeviceCert,
            providerType: SettingsProviderType.deviceCertProviderType,
          ),

          SettingsTile(
            type: SettingsType.brokerPrivateKey,
            providerType: SettingsProviderType.privateKeyProviderType,
          ),
          Divider(),
        ],
      ),
    );
  }
}
