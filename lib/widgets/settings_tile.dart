import 'package:factoryio_app/all_imports.dart';

class SettingsTile extends ConsumerWidget {
  const SettingsTile({
    super.key,
    required this.type,
    required this.providerType,
  });

  final SettingsType type;
  final SettingsProviderType providerType;

  void showDialog(BuildContext context, WidgetRef ref) async {
    // Show a dialog based on the type of setting
    final addreess =
        ref.read(brokerAddressProvider).value ?? defaultBrokerAddress;
    final port = ref.read(brokerPortProvider).value ?? defaultPort;
    final username = ref.read(brokerUsernameProvider).value ?? defaultUsername;
    final password = ref.read(brokerPasswordProvider).value ?? defaultPassword;
    switch (type) {
      case SettingsType.brokerAddress:
        DialogsHelper.updateAddressOrPort(context, addreess, null);

        break;
      case SettingsType.brokerPort:
        DialogsHelper.updateAddressOrPort(context, null, port);

        break;
      case SettingsType.brokerPassword:
        DialogsHelper.updateUsernameOrPasswordDialog(context, password);
        break;
      case SettingsType.brokerUsername:
        DialogsHelper.updateUsernameOrPasswordDialog(context, username);

        break;
      case SettingsType.brokerRootCert:
        String? filePath = await DialogsHelper.pickFile();
        if (filePath != null) {
          ref.read(rootCertProvider.notifier).setFilePath(filePath);
        }
        break;
      case SettingsType.brokerDeviceCert:
        String? filePath = await DialogsHelper.pickFile();
        if (filePath != null) {
          ref.read(deviceCertProvider.notifier).setFilePath(filePath);
        }
        break;
      case SettingsType.brokerPrivateKey:
        String? filePath = await DialogsHelper.pickFile();
        if (filePath != null) {
          ref.read(privateKeyProvider.notifier).setFilePath(filePath);
        }
        break;
    }
  }

  IconData getIcon() {
    switch (type) {
      case SettingsType.brokerAddress:
        return Icons.link;
      case SettingsType.brokerPort:
        return Icons.network_ping;
      case SettingsType.brokerUsername:
        return Icons.person;
      case SettingsType.brokerPassword:
        return Icons.password;
      case SettingsType.brokerRootCert:
        return Icons.file_upload;
      case SettingsType.brokerDeviceCert:
        return Icons.file_upload;
      case SettingsType.brokerPrivateKey:
        return Icons.file_upload;
    }
  }

  String getSubtitle(String value, bool showUnmasked) {
    switch (type) {
      case SettingsType.brokerAddress:
        if (showUnmasked) {
          return value;
        }
        final parts = value.split('.');
        if (parts.length > 1) {
          final lastPart = parts.last;
          final maskedParts = List.filled(parts.length - 1, '*' * 3);
          return [...maskedParts, lastPart].join('.');
        }
        return value;
      case SettingsType.brokerPort:
        return value;
      case SettingsType.brokerUsername:
        return value;
      case SettingsType.brokerPassword:
        if (showUnmasked) {
          return value;
        }
        return value.replaceRange(0, value.length, '*' * value.length);
      case SettingsType.brokerRootCert:
        return value.split('/').last;
      case SettingsType.brokerDeviceCert:
        return value.split('/').last;
      case SettingsType.brokerPrivateKey:
        return value.split('/').last;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(providerType.getProvider());
    bool showUnmasked = false;
    return Card(
      clipBehavior: Clip.hardEdge,
      color: Theme.of(context).colorScheme.onInverseSurface,
      child: StatefulBuilder(
        builder:
            (context, setState) => ListTile(
              title: Text(type.name),
              subtitle: Text(
                provider.hasValue
                    ? getSubtitle(provider.value.toString(), showUnmasked)
                    : '',
              ),
              trailing: IconButton(
                icon: Icon(getIcon()),
                onPressed: () {
                  setState(() {
                    showUnmasked = !showUnmasked;
                  });
                },
              ),
              onTap: () async {
                showDialog(context, ref);
              },
            ),
      ),
    );
  }
}
