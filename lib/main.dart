import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:travalong/firebase_options.dart';
import 'package:travalong/logic/services/auth_service.dart';
import 'package:travalong/presentation/resources/widgets/atoms/safe_scaffold.dart';
import 'package:travalong/presentation/screens/screens.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.removeAfter(initialization);
  await Firebase.initializeApp(
    //name: "FixError", // ! maybee remove
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const TravalongApp());
}

Future initialization(BuildContext? context) async {
  await Future.delayed(const Duration(seconds: 1));
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
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: SafeScaffold(
          // * Listen for auth state changes (if user is logged in)
          child: StreamBuilder<User?>(
            stream: AuthService().firebaseAuth.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasData) // * User is signed in
              {
                return const TravalongNavbar();
              } else if (snapshot.hasError) {
                return const Center(
                  child: Text("Something went wrong..."),
                );
              } else // * User needs to sign in
              {
                return const StartScreen(); //StartScreen();
              }
            },
          ),
        ),
      ),
    );
  }
}
