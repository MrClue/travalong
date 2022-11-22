import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:travalong/presentation/resources/colors.dart';
import 'package:travalong/presentation/start_screens/signin_screen.dart';
import 'package:travalong/presentation/start_screens/signup_screen.dart';

import '../atoms/subtext.dart';
import '../atoms/travalong_title.dart';

class SlideUpWidget extends StatelessWidget {
  const SlideUpWidget({super.key});

  @override
  Widget build(BuildContext context) => SlidingUpPanel(
        // Panel content here
        // Title, sub-title, Sign in, Sign up
        panel: Container(
            alignment: Alignment.topCenter,
            padding: const EdgeInsets.all(40.0),
            child: Column(
              children: [
                const TravalongTitle(),
                const SizedBox(height: 20),
                const Subtext(
                    text:
                        "Finding friends to travel alongside you, has never been easier."),
                const SizedBox(height: 40),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 40,
                  height: 56,
                  child: FloatingActionButton.extended(
                    heroTag: "sign_in_btn1",
                    backgroundColor: TravalongColors.secondary_10,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignInScreen()),
                      );
                    },
                    label: const Text(
                      "Sign In",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 40,
                  height: 56,
                  child: FloatingActionButton.extended(
                    heroTag: "sign_up_btn1",
                    backgroundColor: TravalongColors.primary_30,
                    label: const Text(
                      "Sign Up",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignUpScreen()),
                      );
                    },
                  ),
                ),
              ],
            )),

        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        defaultPanelState: PanelState.OPEN,
        minHeight: 400,
        maxHeight: 400,
        isDraggable: false,
        body: const Center(),
      );
}
