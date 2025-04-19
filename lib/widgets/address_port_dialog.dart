import 'package:factoryio_app/all_imports.dart';

class AdressPortDialog extends ConsumerWidget {
  const AdressPortDialog({
    super.key,
    required this.title,
    required this.address,
    required this.port,
  });

  final String title;
  final String? address;
  final int? port;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String adr = address ?? defaultBrokerAddress;
    int prt = port ?? defaultPort;
    return AlertDialog(
      title: Text(title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          address != null
              ? TextField(
                decoration: const InputDecoration(labelText: 'Broker Address'),
                controller: TextEditingController(text: adr),
                onChanged: (value) {
                  adr = value;
                },
              )
              : TextField(
                decoration: const InputDecoration(labelText: 'Broker Port'),
                keyboardType: TextInputType.number,
                controller: TextEditingController(text: port.toString()),
                onChanged: (value) {
                  prt = int.tryParse(value) ?? 0;
                },
              ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            // Save the changes
            if (address != null) {
              ref.read(brokerAddressProvider.notifier).setAddress(adr);
            } else if (port != null) {
              ref.read(brokerPortProvider.notifier).setPort(prt);
            }
            Navigator.of(context).pop();
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
