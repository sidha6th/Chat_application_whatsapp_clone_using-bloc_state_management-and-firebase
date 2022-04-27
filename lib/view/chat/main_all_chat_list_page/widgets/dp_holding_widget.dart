import 'dart:convert';

import 'package:chat_app/extra/exports/exports.dart';

class DpHoldingWidget extends StatelessWidget {
  const DpHoldingWidget({
    required this.encodedImg,
    this.radius = 40,
    required this.color,
    this.isGroup = false,
    this.size = const Size(40, 40),
    Key? key,
  }) : super(key: key);
  final Size size;
  final double radius;
  final bool isGroup;
  final Color color;
  final String encodedImg;
  @override
  Widget build(BuildContext context) => CircleAvatar(
      child: encodedImg.trim().isEmpty
          ? Icon(!isGroup ? Icons.person : Icons.group, color: white)
          : CircleAvatar(
              backgroundImage:
                  MemoryImage(const Base64Decoder().convert(encodedImg))),
      backgroundColor: color);
}
