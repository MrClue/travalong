import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeText extends StatelessWidget {
  final String textString;
  final double fontSize;
  final FontWeight fontWeight;
  final Color textColor;

  const ThemeText(
      {super.key,
      required this.textString,
      required this.fontSize,
      required this.fontWeight,
      required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Text(
      textString,
      style: GoogleFonts.poppins(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: textColor,
      ),
    );
  }
}

class ThemeTextH2 extends StatelessWidget {
  final String textString;
  final Color textColor;

  const ThemeTextH2(
      {super.key, required this.textString, required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Text(
      textString,
      style: GoogleFonts.poppins(
        fontSize: 20.0,
        fontWeight: FontWeight.w500,
        color: textColor,
      ),
    );
  }
}
