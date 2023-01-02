import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travalong/presentation/resources/colors.dart';

class TravalongTitle extends StatelessWidget {
  const TravalongTitle({super.key});

  @override
  Widget build(BuildContext context) => AutoSizeText.rich(
        TextSpan(
          children: [
            TextSpan(
              text: 'ami',
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 85,
                fontWeight: FontWeight.w900,
                letterSpacing: 0,
                height: 1,
              ),
            ),
            TextSpan(
              text: 'go',
              style: GoogleFonts.poppins(
                color: TravalongColors.secondary_10,
                fontSize: 85,
                fontWeight: FontWeight.w900,
                letterSpacing: 0,
                height: 1,
              ),
            ),
          ],
        ),
        maxLines: 1,
      );
}
