import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:travalong/presentation/widgets/atoms/clickable_button.dart';

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
        children: const [
          TravalongTitle(),
          SizedBox(height: 20),
          Subtext(text: "Finding friends to travel alongside you, has never been easier."),
          SizedBox(height: 40),
          ClickButton(text: "Sign in"),
          SizedBox(height: 20),
          ClickButton(text: "Sign out"),
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
      child: Text("This is the Widget behind the sliding panel"),
    ),


  );
}
