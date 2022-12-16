import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:travalong/presentation/resources/colors.dart';
import 'package:travalong/presentation/screens/start/signin_screen.dart';
import 'package:travalong/presentation/screens/start/signup_screen.dart';

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
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 25, left: 51, right: 51),
                  child: Column(
                    children: const [
                      TravalongTitle(),
                      Subtext(
                        text:
                            "Finding friends to travel alongside you, has never been easier.",
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 36),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 40,
                  height: 56,
                  child: FloatingActionButton.extended(
                    heroTag: "sign_up_btn1",
                    elevation: 0,
                    backgroundColor: TravalongColors.secondary_10,
                    shape: const StadiumBorder(
                      side: BorderSide(
                        color: TravalongColors.secondary_10,
                        width: 1.5,
                      ),
                    ),
                    label: Text(
                      "Sign Up",
                      style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    onPressed: () => showModalBottomSheet(
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20)),
                        ),
                        context: context,
                        builder: (context) {
                          return SizedBox(
                              height: 750,
                              width: MediaQuery.of(context).size.width,
                              child: const SignUpScreen());
                        }),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 40,
                  height: 56,
                  child: FloatingActionButton.extended(
                    heroTag: "sign_in_btn1",
                    elevation: 0,
                    backgroundColor: TravalongColors.primary_30,
                    shape: const StadiumBorder(
                      side: BorderSide(
                        color: TravalongColors.primary_30_stroke,
                        width: 1.5,
                      ),
                    ),
                    label: Text(
                      "Sign In",
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    onPressed: () => showModalBottomSheet(
                        backgroundColor: Colors.transparent,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20)),
                        ),
                        context: context,
                        builder: (context) {
                          return SizedBox(
                              height: 400,
                              width: MediaQuery.of(context).size.width,
                              child: const SignInScreen());
                        }),
                  ),
                ),
              ],
            )),

        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        defaultPanelState: PanelState.OPEN,
        minHeight: 360,
        maxHeight: 360,
        isDraggable: false,
        body: const Center(),
      );
}
