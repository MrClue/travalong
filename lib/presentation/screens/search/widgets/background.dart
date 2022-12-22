// * This widget represents where search results will be displayed

import 'package:flutter/material.dart';
import 'package:travalong/presentation/resources/colors.dart';
import 'package:travalong/presentation/resources/widgets/atoms/theme_text.dart';
import 'package:travalong/presentation/screens/search/widgets/results_grid.dart';

class Background extends StatelessWidget {
  const Background({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 60, left: 14, right: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ThemeTextH2(
            textString: "Suggested Travelers",
            textColor: TravalongColors.primary_text_bright,
          ),
          const SizedBox(height: 18),
          Expanded(child: ResultsGrid()),
        ],
      ),
    );
  }
}
