import 'dart:developer';

import 'package:factoryio_app/providers/settings_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SaveSettingButton extends StatelessWidget {
  const SaveSettingButton({super.key, required this.ref});

  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return IconButton.filledTonal(
      onPressed: () {
        final rootCert = ref.read(rootCertProvider);
        final deviceCert = ref.read(deviceCertProvider);
        final privateKey = ref.read(privateKeyProvider);
        final brokerAddress = ref.read(brokerAddressProvider);
        final brokerPort = ref.read(brokerPortProvider);
        log(
          'File 1: $rootCert, File 2: $deviceCert, File 3: $privateKey, address: $brokerAddress, port: $brokerPort',
        );
      },

      icon: Icon(Icons.save),
    );
  }
}
