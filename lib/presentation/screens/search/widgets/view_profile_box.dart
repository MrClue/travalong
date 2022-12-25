import 'package:flutter/material.dart';

import '../../../resources/colors.dart';
import '../../../resources/widgets/atoms/theme_text.dart';

class ViewProfileBox extends StatelessWidget {
  final String? id;
  final String? _userImage =
      "https://image-cdn.essentiallysports.com/wp-content/uploads/ishowspeed-740x600.jpg";
  final String? name;
  final int? age;
  final String? city;
  final String? country;
  final String? bio;
  final List<String>? interests;
  const ViewProfileBox({
    super.key,
    this.id,
    required this.name,
    required this.age,
    required this.city,
    required this.country,
    required this.bio,
    required this.interests,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: InkWell(
        //onTap: onPressed,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.network(
                  _userImage!,
                  width: 355,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ThemeText(
                      textString: name,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      textColor: TravalongColors.primary_text_bright,
                    ),
                    ThemeText(
                      textString: ' $age',
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      textColor: TravalongColors.primary_text_bright,
                    ),
                    ThemeText(
                      textString: ' $city',
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      textColor: TravalongColors.primary_text_bright,
                    ),
                    ThemeText(
                      textString: ' $country',
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      textColor: TravalongColors.primary_text_bright,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Container(
                  height: 135,
                  width: 355,
                  decoration: const BoxDecoration(
                      color: TravalongColors.primary_30,
                      borderRadius: BorderRadius.all(
                        Radius.circular(15.0),
                      )),
                  child: Column(
                    children: [
                      const ThemeText(
                        textString: 'Bio',
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        textColor: TravalongColors.primary_text_bright,
                      ),
                      ThemeText(
                        textString: ' $bio',
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        textColor: TravalongColors.primary_text_bright,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
