import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travalong/presentation/resources/colors.dart';

class TravalongTitle extends StatelessWidget {
  const TravalongTitle({super.key});

  @override
  Widget build(BuildContext context) => RichText(
        text: TextSpan(
          text: 'TRAV',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: 48,
            fontWeight: FontWeight.w900,
            letterSpacing: 0,
            height: 1,
          ),
          children: <TextSpan>[
            TextSpan(
              text: 'A',
              style: GoogleFonts.poppins(
                color: TravalongColors.secondary_10,
                fontSize: 48,
                fontWeight: FontWeight.w900,
                letterSpacing: 0,
                height: 1,
              ),
            ),
            TextSpan(
              text: 'LONG',
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 48,
                fontWeight: FontWeight.w900,
                letterSpacing: 0,
                height: 1,
              ),
            ),
          ],
        ),
      );
}
