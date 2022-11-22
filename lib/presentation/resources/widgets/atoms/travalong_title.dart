import 'package:flutter/material.dart';
import 'package:travalong/presentation/resources/colors.dart';

class TravalongTitle extends StatelessWidget {
  const TravalongTitle({super.key});

  @override
  Widget build(BuildContext context) => RichText(
        text: const TextSpan(
          text: 'TRAV',
          style: TextStyle(
              color: Colors.black,
              fontSize: 38,
              fontWeight: FontWeight.bold,
              letterSpacing: 10),
          children: <TextSpan>[
            TextSpan(
                text: 'A',
                style: TextStyle(
                    color: TravalongColors.secondary_10,
                    fontSize: 38,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 10)),
            TextSpan(
                text: 'LONG',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 38,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 10)),
          ],
        ),
      );
}
