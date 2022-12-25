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
      padding: const EdgeInsets.all(12.0),
      child: InkWell(
        //onTap: onPressed,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Wrap(
            alignment: WrapAlignment.center,
            spacing: 10,
            runSpacing: 10,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.network(
                  _userImage!,
                  width: 355,
                  //fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                width: 355,
                height: 26,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
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
                      ],
                    ),
                    Row(
                      children: [
                        ThemeText(
                          textString: ' $city',
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          textColor: TravalongColors.primary_text_bright,
                        ),
                        ThemeText(
                          textString: ', $country',
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          textColor: TravalongColors.primary_text_bright,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                height: 135,
                width: 355,
                decoration: const BoxDecoration(
                    color: TravalongColors.primary_30,
                    borderRadius: BorderRadius.all(
                      Radius.circular(15.0),
                    )),
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.topLeft,
                      child: ThemeText(
                        textString: 'Bio',
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        textColor: TravalongColors.primary_text_bright,
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: ThemeText(
                          textString: '$bio',
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          textColor: TravalongColors.primary_text_bright,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 55,
                width: 355,
                decoration: const BoxDecoration(
                    color: TravalongColors.primary_30,
                    borderRadius: BorderRadius.all(
                      Radius.circular(15.0),
                    )),
                child: Column(
                  children: const [
                    Align(
                      alignment: Alignment.topLeft,
                      child: ThemeText(
                        textString: 'You both like..',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        textColor: TravalongColors.primary_text_bright,
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: ThemeText(
                          textString: '-- Similar interest here --',
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          textColor: TravalongColors.primary_text_bright,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
