import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PageTextTopCenter extends StatelessWidget {
  final String textNormal;
  final String textBold;

  const PageTextTopCenter({
    Key? key,
    required this.textNormal,
    required this.textBold,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.left,
      text: TextSpan(
        // Note: Styles for TextSpans must be explicitly defined.
        // Child text spans will inherit styles from parent
        style: GoogleFonts.poppins(
          fontSize: 16.0,
          color: Colors.black,
        ),
        children: <TextSpan>[
          TextSpan(text: textNormal),
          TextSpan(
              text: textBold,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              )),
        ],
      ),
    );
  }
}
