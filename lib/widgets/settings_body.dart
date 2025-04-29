import 'package:factoryio_app/all_imports.dart';

class SettingsBody extends ConsumerWidget {
  const SettingsBody({super.key, required this.backgroundColor});
  final Color backgroundColor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(8.0),

        children: [
          TextWidget(
            text: 'User',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            backgroundColor: backgroundColor,
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
          TextWidget(
            text: 'Broker',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            backgroundColor: backgroundColor,
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
          TextWidget(
            text: 'Certificates',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            backgroundColor: backgroundColor,
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
          SizedBox(height: 20),
          TextWidget(
            text: 'Theme',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            backgroundColor: backgroundColor,
          ),
          Divider(),
          SettingsTile(
            type: SettingsType.backgroundColor,
            providerType: SettingsProviderType.backgroundColorProviderType,
          ),
        ],
      ),
    );
  }
}
