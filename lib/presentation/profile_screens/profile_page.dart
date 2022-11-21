import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travalong/logic/user.dart';
import 'package:travalong/logic/user_data.dart';
import 'package:travalong/presentation/profile_screens/my_goals_page.dart';
import 'package:travalong/presentation/profile_screens/my_profile_page.dart';
import "package:travalong/presentation/resources/colors.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = UserData.dummyUser;

    return Scaffold(
      backgroundColor: TravalongColors.neutral_60,
      body: SafeArea(
        child: Column(
          children: [
            ProfileWidget(user: user),
            const SizedBox(
              height: 30,
            ),
            const IconTextButton(
              faIcon: FontAwesomeIcons.solidUser,
              label: "My Profile",
              description: "Update your profile information here.",
              goToPage: MyProfilePage(),
            ),
            const SizedBox(height: 8),
            const IconTextButton(
              faIcon: FontAwesomeIcons.list,
              label: "My Goals",
              description: "Set travel goals, and stay on track.",
              goToPage: MyGoalsPage(),
            ),
            // TODO: Shared Media
          ],
        ),
      ),
    );
  }
}

class IconTextButton extends StatelessWidget {
  final IconData faIcon;
  final String label;
  final String description;
  final Widget goToPage;

  const IconTextButton({
    Key? key,
    required this.faIcon,
    required this.label,
    required this.description,
    required this.goToPage,
  }) : /*assert(goToPage != null),*/
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (() {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => goToPage),
        );
      }),
      child: Container(
        width: MediaQuery.of(context).size.width - 28,
        height: 65,
        //margin: const EdgeInsets.only(left: 14, right: 14),
        padding: const EdgeInsets.only(left: 7, right: 7),
        decoration: BoxDecoration(
          color: TravalongColors.primary_30,
          border: Border.all(
            color: TravalongColors.primary_30_stroke,
            width: 1.5,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  width: 35,
                  child: FaIcon(
                    faIcon,
                    size: 35,
                    color: TravalongColors.secondary_10,
                  ),
                ),
                //const SizedBox(width: 7),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: GoogleFonts.poppins(
                          fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      description,
                      style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: TravalongColors.secondary_text_bright),
                    ),
                  ],
                ),
              ],
            ),
            const FaIcon(
              FontAwesomeIcons.angleRight,
              size: 24,
              color: TravalongColors.secondary_10,
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 215,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            spreadRadius: 0,
            blurRadius: 4,
            offset: const Offset(0, 4), // changes position of shadow
          )
        ],
        color: Colors.white, // TODO change to actual theme color
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(15.0),
          bottomRight: Radius.circular(15.0),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        //crossAxisAlignment: CrossAxisAlignment.center, // ! maybee not needed
        children: [
          // * top row
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(user.imagePath),
              ),
              const SizedBox(
                width: 15.0,
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Text(
                        user.name,
                        style: GoogleFonts.poppins(
                            fontSize: 30, fontWeight: FontWeight.w700),
                      ),
                      Text(
                        ", ${user.age}",
                        style: GoogleFonts.poppins(
                            fontSize: 24, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  Text(
                    "${user.city}, ${user.country}",
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(
            height: 25.0,
          ),
          // * bottom row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text(
                    "${user.connections}",
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "Connections",
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    "${user.media}",
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "Shared Media",
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    "${user.goalsCompleted}%",
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "Goals Acheived",
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
