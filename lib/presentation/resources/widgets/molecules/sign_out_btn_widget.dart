import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travalong/logic/services/auth_service.dart';
import 'package:travalong/presentation/resources/colors.dart';
import 'package:travalong/presentation/resources/widgets/atoms/theme_container.dart';
import 'package:travalong/presentation/resources/widgets/atoms/theme_text.dart';
import 'package:travalong/presentation/screens/screens.dart';

class SignOutBtnWidget extends StatelessWidget {
  const SignOutBtnWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showCupertinoDialog(
          context: context,
          builder: (_) => CupertinoAlertDialog(
            title: const Text('Sign out'),
            content: const Text('Are you sure you want to sign out?'),
            actions: [
              TextButton(
                child: const ThemeText(
                  textString: "No",
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                  textColor: Colors.black,
                ),
                onPressed: () =>
                    Navigator.of(context, rootNavigator: true).pop('dialog'),
              ),
              TextButton(
                child: const ThemeText(
                  textString: "Sign out",
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                  textColor: Colors.red,
                ),
                onPressed: () {
                  AuthService().signOut();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const StartScreen(),
                    ),
                  );
                },
              )
            ],
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
