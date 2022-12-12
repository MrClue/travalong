import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travalong/presentation/resources/colors.dart';

class BackArrow extends StatelessWidget {
  const BackArrow({super.key});

  @override
  Widget build(BuildContext context) => IconButton(
        //constraints: const BoxConstraints.expand(width: 80),
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const FaIcon(
          FontAwesomeIcons.angleLeft,
          size: 24,
          color: TravalongColors.secondary_10,
        ), /*const Icon(
          size: 25,
          Icons.arrow_back_ios,
          color: TravalongColors.secondary_10,
        ),*/
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
            child: Text(
              "Cancel",
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
