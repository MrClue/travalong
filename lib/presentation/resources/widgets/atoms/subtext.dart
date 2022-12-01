import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travalong/presentation/resources/colors.dart';

class Subtext extends StatelessWidget {
  final String text;

  const Subtext({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) => Text(
        text,
        style: GoogleFonts.poppins(
          color: TravalongColors.secondary_text_dark,
          fontWeight: FontWeight.w400,
          fontSize: 15,
        ),
      );
}
