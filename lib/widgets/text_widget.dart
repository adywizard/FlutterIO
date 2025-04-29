import 'package:factoryio_app/all_imports.dart';

class TextWidget extends StatelessWidget {
  const TextWidget({
    super.key,
    required this.text,
    this.fontSize,
    this.fontWeight,
    required this.backgroundColor,
  });

  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    final color = ColorResolver.calculateTextColor(backgroundColor);
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );
  }
}
