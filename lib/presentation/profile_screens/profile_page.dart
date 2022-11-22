// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:travalong/logic/user_data.dart';
import 'package:travalong/presentation/profile_screens/my_goals_page.dart';
import 'package:travalong/presentation/profile_screens/my_profile_page.dart';
import 'package:travalong/presentation/resources/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travalong/presentation/resources/widgets/molecules/profile_widget.dart';
import 'package:travalong/presentation/resources/widgets/molecules/icon_text_btn_widget.dart';

import '../resources/widgets/molecules/navbar.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    const user = UserData.dummyUser;

    return Scaffold(
      backgroundColor: TravalongColors.neutral_60,
      bottomNavigationBar: NavBar(),
      body: SafeArea(
        child: Column(
          children: [
            ProfileWidget(user: user),
            SizedBox(
              height: 30,
            ),
            IconTextButton(
              faIcon: FontAwesomeIcons.solidUser,
              label: "My Profile",
              description: "Update your profile information here.",
              goToPage: MyProfilePage(),
            ),
            SizedBox(height: 8),
            IconTextButton(
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
