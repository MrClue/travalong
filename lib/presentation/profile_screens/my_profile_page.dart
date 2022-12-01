import "package:flutter/material.dart";
import 'package:travalong/presentation/resources/widgets/atoms/safe_scaffold.dart';
import 'package:travalong/presentation/resources/widgets/molecules/about_form.dart';
import 'package:travalong/presentation/resources/widgets/molecules/interest_hobbies_widget.dart';
import 'package:travalong/presentation/resources/widgets/molecules/location_widget.dart';
import 'package:travalong/presentation/resources/widgets/molecules/sign_out_btn_widget.dart';
import 'package:travalong/presentation/resources/widgets/molecules/topbar_done.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({super.key});

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  @override
  Widget build(BuildContext context) {
    return SafeScaffoldNoNavbar(
      topbar: const TopBarDone(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Column(
          children: const [
            SizedBox(
              height: 30,
            ),
            AboutFormWidget(),
            SizedBox(
              height: 16, // figma: 26 -> but looks weird
            ),
            LocationWidget(),
            SizedBox(
              height: 26,
            ),
            InterestsHobbiesWidget(),
            SizedBox(
              height: 26, // todo: use remaining available height
            ),
            SignOutBtnWidget(),
          ],
        ),
      ),
    );
  }
}
