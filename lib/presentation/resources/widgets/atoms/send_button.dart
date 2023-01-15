import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travalong/presentation/resources/colors.dart';

class SendButton extends StatelessWidget {
  const SendButton({
    Key? key,
    required this.color,
    required this.icon,
    this.size = 54,
    required this.onPressed,
  }) : super(key: key);

  final Color color;
  final IconData icon;
  final double size;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      hoverColor: TravalongColors.neutral_60,
      onTap: onPressed,
      child: Center(
        child: Text(
          "Send",
          style: GoogleFonts.poppins(
            color: TravalongColors.secondary_10,
            fontSize: 16,
            fontWeight: FontWeight.normal,
            letterSpacing: 2,
          ),
        ),
      ),
    );
  }
}