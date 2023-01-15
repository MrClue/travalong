import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travalong/logic/services/auth_service.dart';
import 'package:travalong/presentation/resources/colors.dart';
import 'package:travalong/presentation/resources/widgets/theme/theme_container.dart';
import 'package:travalong/presentation/resources/widgets/theme/theme_text.dart';
import 'package:travalong/presentation/screens/screens.dart';

class SignOutBtnWidget extends StatelessWidget {
  const SignOutBtnWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        AuthService().signOut();
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const StartScreen(),
          ),
        );
      },
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
