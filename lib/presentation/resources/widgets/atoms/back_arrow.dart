import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travalong/presentation/resources/colors.dart';

class BackArrow extends StatelessWidget {
  const BackArrow({super.key});

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: const Icon(
          size: 25,
          Icons.arrow_back_ios,
          color: Colors.black54,
        ),
      );
}

class CancelArrow extends StatelessWidget {
  const CancelArrow({super.key});

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: () {
      Navigator.pop(context);
    },
    child: Center(
      child: SizedBox(
        height: 30,
        width: 100,
        child: Text("Cancel",
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.normal,
            color: TravalongColors.secondary_10,
          ),
        ),
      ),
    ),
  );
}
