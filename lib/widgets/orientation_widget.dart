import 'package:flutter/material.dart';

class ParentOrientation extends StatelessWidget {
  const ParentOrientation({super.key, required this.children});
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.portrait
        ? Column(children: children)
        : Row(children: children);
  }
}
