import 'package:flutter/material.dart';
import 'package:travalong/presentation/screens/search/widgets/profile_image.dart';

import '../../../resources/colors.dart';
import '../../../resources/widgets/theme/theme_text.dart';

class ProfileSquare extends StatelessWidget {
  final String name; // users name
  final String image; // users 1st image
  final dynamic onPressed;
  final int sharedInterests;

  const ProfileSquare({
    Key? key,
    required this.name,
    required this.image,
    required this.onPressed,
    required this.sharedInterests,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: InkWell(
        onTap: onPressed,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            //color: Colors.grey[200], // ! debug størrelse på container
          ),
          child: Column(
            children: [
              ProfileImagePreview(
                image: image,
                sharedInterests: sharedInterests,
              ),
              Expanded(
                child: Flex(
                  direction: Axis.vertical,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ThemeText(
                      textString: name,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      textColor: TravalongColors.primary_text_bright,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
