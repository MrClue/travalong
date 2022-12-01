import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:travalong/presentation/profile_screens/home_page.dart';
import 'package:travalong/presentation/start_screens/start_screen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: "FixError",
    options: const FirebaseOptions(
        apiKey: "AIzaSyBPbZYzpFnjSK099uCQL7W12GG7VWa-M8c",
        authDomain: "travalong-33ad7.firebaseapp.com",
        projectId: "travalong-33ad7",
        storageBucket: "travalong-33ad7.appspot.com",
        messagingSenderId: "881914006921",
        appId: "1:881914006921:web:7f1917cf3ffabb01926558"),
  );

  runApp(const TravalongApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

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
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'TRAVALONG',
        theme: ThemeData(visualDensity: VisualDensity.adaptivePlatformDensity),
        home: Scaffold(
          body: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasData) {
                return HomePage();
              } else if (snapshot.hasError) {
                return const Center(
                  child: Text("Something went wrong..."),
                );
              } else {
                return HomePage(); //StartScreen();
              }
            },
          ),
        ),
      ),
    );
  }
}
