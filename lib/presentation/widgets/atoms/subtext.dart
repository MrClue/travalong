import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Subtext extends StatelessWidget {
  final String text;

  const Subtext({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) => Text(text,
    style: GoogleFonts.poppins(
      color: Colors.black45,
      fontWeight: FontWeight.bold,
      fontSize: 14
    ),
  );

}