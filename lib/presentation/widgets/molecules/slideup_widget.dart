import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:travalong/presentation/screens/signin_screen.dart';
import 'package:travalong/presentation/screens/signup_screen.dart';

import '../atoms/subtext.dart';
import '../atoms/travalong_title.dart';

class SlideUpWidget extends StatelessWidget {
  SlideUpWidget({super.key});

  Color textFieldFormColor = Color(0xFFF5F8FD);
  Color buttonColor = Color(0xFF2ABAFF);

  @override
  Widget build(BuildContext context) => SlidingUpPanel(
    // Panel content here
    // Title, sub-title, Sign in, Sign up
    panel: Container(
      alignment: Alignment.topCenter,
      padding: const EdgeInsets.all(40.0),
      child: Column(
        children: [
          TravalongTitle(),
          SizedBox(height: 20),
          Subtext(text: "Finding friends to travel alongside you, has never been easier."),
          SizedBox(height: 40),
          SizedBox(
            width: 400,
            height: 50,
            child: FloatingActionButton.extended(
              backgroundColor: buttonColor,
              onPressed:(){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignInScreen()),
                );
              },
              label: Text("Sign In",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          SizedBox(
            width: 400,
            height: 50,
            child: FloatingActionButton.extended(
              backgroundColor: textFieldFormColor,
              label: Text("Sign Up",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
              onPressed:(){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpScreen()),
                );
              },
            ),
          ),
        ],
      )
    ),

    borderRadius: const BorderRadius.only(
    topLeft: Radius.circular(20.0),
    topRight: Radius.circular(20.0),
    ),
    defaultPanelState: PanelState.OPEN,
    minHeight: 400,
    maxHeight: 400,
    isDraggable: false,
    body: const Center(
    ),


  );
}
