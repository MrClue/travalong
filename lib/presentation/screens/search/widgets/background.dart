// * This widget represents where search results will be displayed

import 'package:flutter/material.dart';
import 'package:travalong/presentation/resources/colors.dart';
import 'package:travalong/presentation/resources/widgets/theme/theme_text.dart';
import 'package:travalong/presentation/screens/search/widgets/results_grid.dart';

class Background extends StatelessWidget {
  final DateTime startDate, endDate;
  final String genderType, searchType;

  const Background({
    super.key,
    required this.startDate,
    required this.endDate,
    required this.genderType,
    required this.searchType,
  });

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
          Expanded(
            child: ResultsGrid(
              startDate: startDate,
              endDate: endDate,
              genderType: genderType,
              searchType: searchType,
            ),
          ),
        ],
      ),
    );
  }
}
