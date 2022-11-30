import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travalong/presentation/resources/colors.dart';

import '../atoms/theme_container.dart';
import '../atoms/theme_text.dart';

class InterestsHobbiesWidget extends StatelessWidget {
  const InterestsHobbiesWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ThemeTextH2(
          textString: "Interests & Hobbies",
          textColor: Colors.black,
        ),
        const SizedBox(height: 12),
        InkWell(
          onTap: (() {
            /*Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => goToPage),
            );*/
          }),
          child: ThemeContainer(
            height: 65,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                ThemeText(
                  textString: "Item 1, Item 2, Item 3,...",
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  textColor: Colors.black,
                ),
                FaIcon(
                  FontAwesomeIcons.angleRight,
                  size: 24,
                  color: TravalongColors.secondary_10,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
