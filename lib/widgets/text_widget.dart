import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TextWidget extends StatelessWidget {
  final String text;
  final double? size;
  final Color? color;
  final int? maxLines;
  final TextAlign? textAlign;
  final FontWeight? fontWeight;
  final List<Shadow>? listShadow;
  final TextDecoration? textDecoration;

  const TextWidget({
    Key? key,
    this.textAlign,
    this.listShadow,
    this.maxLines = 10,
    required this.text,
    this.color = Colors.black,
    this.size = 16,
    this.fontWeight = FontWeight.normal,
    this.textDecoration = TextDecoration.none,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text.tr,
      maxLines: maxLines,
      textAlign: textAlign,
      style: TextStyle(
        color: color,
        fontSize: size,
        shadows: listShadow,
        fontWeight: fontWeight,
        decoration: textDecoration,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
