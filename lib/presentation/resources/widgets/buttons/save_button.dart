import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';

import '../../colors.dart';

class SaveButtonWidget extends StatelessWidget {
  final void onPress;

  const SaveButtonWidget({
    Key? key,
    required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      constraints: const BoxConstraints.expand(width: 80),
      icon: Text(
        'Save',
        textAlign: TextAlign.center,
        style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: TravalongColors.secondary_10),
      ),
      onPressed: (() => {
            onPress,
            Navigator.pop(context) // return to previous page
          }),
    );
  }
}
