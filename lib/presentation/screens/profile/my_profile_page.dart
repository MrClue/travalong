import "package:flutter/material.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travalong/presentation/resources/widgets/theme/back_arrow.dart';
import 'package:travalong/presentation/resources/widgets/theme/safe_scaffold.dart';
import 'package:travalong/presentation/screens/profile/widgets/about_form.dart';
import 'package:travalong/presentation/resources/widgets/buttons/icon_text_btn_widget.dart';
import 'package:travalong/presentation/screens/profile/widgets/location_widget.dart';
import 'package:travalong/presentation/resources/widgets/buttons/sign_out_btn_widget.dart';
import 'package:travalong/presentation/resources/widgets/navigation/theme_topbar.dart';
import 'package:travalong/presentation/screens/profile/interests_subpage.dart';

import 'my_goals_page.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({super.key});

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  @override
  Widget build(BuildContext context) {
    return SafeScaffold(
      topbar: const ThemeTopBar(
        title: "My Profile",
        backArrow: BackArrow(),
        enableCustomButton: false,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Column(
          children: const [
            SizedBox(height: 30),
            AboutFormWidget(),
            SizedBox(height: 16), // figma: 26 -> but looks weird
            LocationWidget(),
            SizedBox(height: 30),
            //InterestsHobbiesWidget(goToPage: InterestsSubpage()),
            IconTextButton(
              faIcon: FontAwesomeIcons.list,
              label: "Interests & Hobbies",
              description: "Select your interests and hobbies.",
              goToPage: InterestsSubpage(),
            ),
            SizedBox(height: 8),
            IconTextButton(
              faIcon: FontAwesomeIcons.list,
              label: "Travel Goals",
              description: "Set travel goals, and stay on track.",
              goToPage: MyGoalsPage(),
            ),
            Spacer(), // fills remaining space
            SignOutBtnWidget(),
            SizedBox(height: 26), // ! maybee remove
          ],
        ),
      ),
    );
  }
}
