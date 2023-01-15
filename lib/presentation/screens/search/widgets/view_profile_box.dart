import 'package:flutter/material.dart';
import 'package:travalong/presentation/screens/search/widgets/profile_image.dart';

import '../../../resources/colors.dart';
import '../../../resources/widgets/theme/theme_text.dart';

class ViewProfileBox extends StatelessWidget {
  final String? id;
  final String userImage;
  final String name;
  final int? age;
  final String? city;
  final String? country;
  final String bio;
  final List<String>? interests;
  final dynamic onTapped;
  final int sharedInterests;

  const ViewProfileBox({
    super.key,
    this.id,
    required this.name,
    required this.age,
    required this.city,
    required this.country,
    required this.bio,
    required this.interests,
    required this.onTapped,
    required this.sharedInterests,
    required this.userImage,
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
              // * Profile image
              ProfileImagePreview(
                image: userImage,
                sharedInterests: sharedInterests,
                height: MediaQuery.of(context).size.height * 0.5,
                hasButton: true,
                onTapped: onTapped,
              ),
              // * Name, age, city, country
              SizedBox(
                width: MediaQuery.of(context).size.width - 50, //355
                height: 25,
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
              // * Bio
              Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.25,
                    width: MediaQuery.of(context).size.width - 50, //355
                    margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    decoration: BoxDecoration(
                      color: TravalongColors.primary_30,
                      border: Border.all(
                        color: TravalongColors.primary_30_stroke,
                        width: 1.5,
                      ),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10.0)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Expanded(
                            child: Align(
                              alignment: Alignment.center,
                              child: ThemeText(
                                textString: bio,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                textColor: TravalongColors.primary_text_bright,
                              ),
                            ),
                          ),
                          const Align(
                            alignment: Alignment.center,
                            child: ThemeText(
                              textString: 'You both like...',
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              textColor: TravalongColors.primary_text_bright,
                            ),
                          ),
                          const Expanded(
                            child: Align(
                              alignment: Alignment.topCenter,
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
                    ),
                  ),
                  Positioned(
                    top: 5,
                    left: 25,
                    right: 0,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                      ),
                      child: const ThemeText(
                        textString: 'Bio',
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        textColor: TravalongColors.primary_text_bright,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
