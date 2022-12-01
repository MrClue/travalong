import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travalong/logic/user_data.dart';
import 'package:travalong/presentation/profile_screens/my_goals_page.dart';
import 'package:travalong/presentation/profile_screens/my_profile_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travalong/presentation/resources/widgets/atoms/safe_scaffold.dart';
import 'package:travalong/presentation/resources/widgets/molecules/profile_widget.dart';
import 'package:travalong/presentation/resources/widgets/molecules/icon_text_btn_widget.dart';

import '../resources/widgets/molecules/navbar.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final userAuth = FirebaseAuth.instance.currentUser!;

    const user = UserData.dummyUser;
    // https://www.youtube.com/watch?v=CX9_op-OW8g&list=PLCAZyR6zw2pyyjdifS_AFJf6HA4Ud8R4_&index=9

    return SafeScaffoldNoTopbar(
      navbar: NavBar(),
      child: Column(
        children: const [
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
    );
  }
}

// jeg arbejder her