import 'package:chat_app/extra/exports/exports.dart';

class TextWidget extends StatelessWidget {
  const TextWidget(
      {required this.text,
      this.overflow=TextOverflow.ellipsis,
      this.align = TextAlign.start,
      this.size = 15,
      this.weight = FontWeight.normal,
      this.color = Colors.white,
      Key? key})
      : super(key: key);
  final String text;
  final double size;
  final FontWeight weight;
  final Color color;
  final TextAlign align;
  final TextOverflow overflow;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align,
      style: TextStyle(
        fontSize: size,
        fontWeight: weight,
        color: color,
      ),
      overflow: overflow,
    );
  }
}
