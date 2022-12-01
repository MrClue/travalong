import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travalong/presentation/resources/colors.dart';
import 'package:travalong/presentation/resources/widgets/atoms/theme_container.dart';
import 'package:travalong/presentation/resources/widgets/atoms/theme_text.dart';

class SignOutBtnWidget extends StatelessWidget {
  const SignOutBtnWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => FirebaseAuth.instance.signOut(),
      child: ThemeContainerAlt(
        height: 45,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            ThemeText(
              textString: "Sign Out",
              fontSize: 20,
              fontWeight: FontWeight.w500,
              textColor: Colors.black,
            ),
            FaIcon(
              FontAwesomeIcons.arrowRightFromBracket,
              color: TravalongColors.secondary_10,
            )
          ],
        ),
      ),
    );
  }
}
