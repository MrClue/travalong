import 'package:flutter/material.dart';
import 'package:travalong/presentation/screens.dart';

void main() {
  runApp(const TravalongApp());
}

class TravalongApp extends StatelessWidget {
  const TravalongApp({super.key});

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    // * wrapping top of widget tree with a "gesture detector",
    // * to dismiss keyboard when clicking away from a textfield.
    // inspiration: https://flutterigniter.com/dismiss-keyboard-form-lose-focus/

    return GestureDetector(
      onTap: () {
        // * We need to remove “focus” from our text field, for the keyboard to dismiss itself.
        // * This is done by removing current focus from the text fields "FocusNode".
        FocusScopeNode currentFocus =
            FocusScope.of(context); // gets current FocusNode

        // check if the current FocusNode has the “primary focus.”
        // ! prevents exception, when trying to unfocus the node at the top of the tree
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          //currentFocus.unfocus();
          FocusManager.instance.primaryFocus!.unfocus(); // cant be null
        }
      },
      child: const MaterialApp(
        title: 'TRAVALONG',
        home:
            ProfilePage(), // * route that is displayed first when app starts (unless "initialRoute" is specified)
      ),
    );
  }

  /*
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'TRAVALONG',
      home:
          ProfilePage(), // ! route that is displayed first when app starts (unless "initialRoute" is specified)
    );
  }
  */
}
