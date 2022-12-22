import 'package:flutter/material.dart';

import '../../../resources/colors.dart';
import '../../../resources/widgets/atoms/theme_text.dart';

class ProfileSquare extends StatelessWidget {
  final String name; // users name
  final String image; // users 1st image
  final Widget goToPage;
  final Function() debug; // ! test

  const ProfileSquare({
    Key? key,
    required this.name,
    required this.image,
    required this.goToPage,
    required this.debug, // ! test
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: InkWell(
        onTap: () {
          debugPrint("You clicked on: $name");
          debug(); // ! test
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => goToPage),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            //color: Colors.grey[200], // ! debug størrelse på container
          ),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.network(
                  image,
                  height: 200,
                  fit: BoxFit.cover,
                ),
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
