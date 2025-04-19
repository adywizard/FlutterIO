import 'package:factoryio_app/all_imports.dart';

class DialogsHelper {
  static Future<List<String?>> updateUsernameOrPasswordDialog(
    BuildContext context,
    String creds,
  ) async {
    String? username;
    String? password;
    return await showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text(credTitle),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (creds == defaultUsername)
                TextField(
                  decoration: InputDecoration(labelText: "Username"),
                  controller: TextEditingController(text: creds),
                  onChanged: (value) {
                    username = value;
                  },
                ),
              if (creds == defaultPassword)
                TextField(
                  decoration: InputDecoration(labelText: "Password"),
                  controller: TextEditingController(text: creds),
                  onChanged: (value) {
                    password = value;
                  },
                ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop([username, password]),
            ),
            TextButton(
              child: const Text('OK'),
              onPressed: () => Navigator.of(context).pop([username, password]),
            ),
          ],
        );
      },
    );
  }

  static Future<dynamic> updateAddressOrPort(
    BuildContext context,
    String? address,
    int? port,
  ) async {
    String title = "";
    if (port == null) {
      title = "Update broker address";
    } else if (address == null) {
      title = "Update broker port";
    } else {
      return;
    }
    return await showDialog(
      context: context,
      builder: (_) {
        return AdressPortDialog(title: title, address: address, port: port);
      },
    );
  }

  static Future<String?> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    {
      if (result != null) {
        return result.files.single.path;
      }
      return null; // Placeholder for the actual file path
    }
  }
}
