import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:travalong/presentation/profile_screens/interests_subpage.dart';
import 'package:travalong/presentation/resources/widgets/atoms/back_arrow.dart';
import 'package:travalong/presentation/resources/widgets/atoms/safe_scaffold.dart';
import 'package:travalong/presentation/resources/widgets/molecules/about_form.dart';
import 'package:travalong/presentation/resources/widgets/molecules/interest_hobbies_widget.dart';
import 'package:travalong/presentation/resources/widgets/molecules/location_widget.dart';
import 'package:travalong/presentation/resources/widgets/molecules/sign_out_btn_widget.dart';
import 'package:travalong/presentation/resources/widgets/molecules/theme_topbar.dart';

import '../resources/colors.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({super.key});

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  @override
  Widget build(BuildContext context) {
    return SafeScaffoldNoNavbar(
      topbar: ThemeTopBar(
        title: "My Profile",
        backArrow: const BackArrow(),
        enableCustomButton: true,
        customButtonWidget:
            SaveButtonWidget(onPress: () => saveAction()), // todo: fix warning
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Column(
          children: const [
            SizedBox(height: 30),
            AboutFormWidget(),
            SizedBox(height: 16), // figma: 26 -> but looks weird
            LocationWidget(),
            SizedBox(height: 26),
            InterestsHobbiesWidget(goToPage: InterestsSubpage()),
            Spacer(), // fills remaining space
            SignOutBtnWidget(),
            SizedBox(height: 26), // ! maybee remove
          ],
        ),
      ),
    );
  }

  // * onPress parameter for SaveButtonWidget
  void saveAction() {
    // TODO: Save stuff to database
  }
}

class SaveButtonWidget extends StatelessWidget {
  final void onPress;

  const SaveButtonWidget({
    Key? key,
    required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      constraints: const BoxConstraints.expand(width: 80),
      icon: Text(
        'Save',
        textAlign: TextAlign.center,
        style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: TravalongColors.secondary_10),
      ),
      onPressed: (() => {
            onPress,
            Navigator.pop(context) // return to previous page
          }),
    );
  }
}
