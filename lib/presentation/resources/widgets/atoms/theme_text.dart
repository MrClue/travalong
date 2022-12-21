import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeText extends StatelessWidget {
  final String textString;
  final double fontSize, height;
  final FontWeight fontWeight;
  final Color textColor;
  final int maxLines;
  final TextOverflow? overflow;

  const ThemeText({
    super.key,
    required this.textString,
    required this.fontSize,
    required this.fontWeight,
    required this.textColor,
    this.maxLines = 999,
    this.height = 0.0,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      textString,
      maxLines: maxLines,
      style: GoogleFonts.poppins(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: textColor,
        height: height,
      ),
    );
  }
}

class ThemeTextH2 extends StatelessWidget {
  final String textString;
  final Color textColor;
  final int maxLines;
  final double height;

  const ThemeTextH2({
    super.key,
    required this.textString,
    required this.textColor,
    this.maxLines = 1,
    this.height = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      textString,
      maxLines: maxLines,
      style: GoogleFonts.poppins(
        fontSize: 20.0,
        fontWeight: FontWeight.w500,
        color: textColor,
        height: height,
      ),
    );
  }
}
