import 'package:flutter/material.dart';

class BRBText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  const BRBText({
    super.key,
    required this.text,
    required this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
  });

  BRBText.pageTitle({
    super.key,
    required this.text,
    this.textAlign,
    Color? color,
    this.maxLines,
    this.overflow,
  }) : style = TextStyle(
          fontSize: 27,
          fontWeight: FontWeight.bold,
          fontFamily: 'Montserrat',
          color: color ?? const Color(0xff006B2E),
        );

  BRBText.headlineLarge({
    super.key,
    required this.text,
    this.textAlign,
    Color? color,
    this.maxLines,
    this.overflow,
  }) : style = TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: color ?? Colors.black,
        );

  BRBText.headlineMedium({
    super.key,
    required this.text,
    this.textAlign,
    Color? color,
    this.maxLines,
    this.overflow,
  }) : style = TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w500,
          color: color ?? Colors.black,
        );

  BRBText.headlineSmall({
    super.key,
    required this.text,
    this.textAlign,
    Color? color,
    this.maxLines,
    this.overflow,
  }) : style = TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: color ?? Colors.black,
        );

  BRBText.titleLarge({
    super.key,
    required this.text,
    this.textAlign,
    Color? color,
    this.maxLines,
    this.overflow,
  }) : style = TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: color ?? Colors.black,
        );

  BRBText.title1({
    super.key,
    required this.text,
    this.textAlign,
    Color? color,
    this.maxLines,
    this.overflow,
  }) : style = TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
          color: color ?? Colors.black,
        );

  BRBText.content({
    super.key,
    required this.text,
    this.textAlign,
    Color? color,
    this.maxLines,
    this.overflow,
  }) : style = TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w400,
          color: color ?? Colors.black,
        );

  BRBText.bodyLarge({
    super.key,
    required this.text,
    this.textAlign,
    Color? color,
    this.maxLines,
    this.overflow,
  }) : style = TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: color ?? Colors.black,
        );

  BRBText.bodyMedium({
    super.key,
    required this.text,
    this.textAlign,
    Color? color,
    this.maxLines,
    this.overflow,
  }) : style = TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: color ?? Colors.black,
        );

  BRBText.bodySmall({
    super.key,
    required this.text,
    this.textAlign,
    Color? color,
    this.maxLines,
    this.overflow,
  }) : style = TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: color ?? Colors.black,
        );

  BRBText.labelMedium({
    super.key,
    required this.text,
    this.textAlign,
    Color? color,
    this.maxLines,
    this.overflow,
  }) : style = TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: color ?? Colors.black,
        );

  BRBText.labelSmall({
    super.key,
    required this.text,
    this.textAlign,
    Color? color,
    this.maxLines,
    this.overflow,
  }) : style = TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: color ?? Colors.black,
        );

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
    );
  }
}
