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

  static Future<int?> setDailyGoalDialog(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (_) {
        int? dailyGoal;
        return AlertDialog(
          title: const Text("Set daily goal"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: "Daily goal"),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  dailyGoal = int.tryParse(value);
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(null),
            ),
            TextButton(
              child: const Text('OK'),
              onPressed: () => Navigator.of(context).pop(dailyGoal),
            ),
          ],
        );
      },
    );
  }
}

class ChangeEndian {
  static int fromLittleEndian(int value) {
    return ((value & 0x000000FF) << 24) |
        ((value & 0x0000FF00) << 8) |
        ((value & 0x00FF0000) >> 8) |
        ((value & 0xFF000000) >> 24);
  }

  static int fromBigEndian(int value) {
    return ((value & 0x000000FF) >> 24) |
        ((value & 0x0000FF00) >> 8) |
        ((value & 0x00FF0000) << 8) |
        ((value & 0xFF000000) << 24);
  }
}
