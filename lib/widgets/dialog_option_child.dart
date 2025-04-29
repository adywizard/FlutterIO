import 'package:flutter/material.dart';

class DialogOptionChild extends StatelessWidget {
  const DialogOptionChild({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      spacing: 16,
      children: [const Icon(Icons.colorize), Text(title)],
    );
  }
}
