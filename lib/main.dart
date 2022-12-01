import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:travalong/presentation/profile_screens/home_page.dart';
import 'package:travalong/presentation/resources/widgets/molecules/show_snack_bar.dart';
import 'package:travalong/presentation/start_screens/start_screen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
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

  //This widget is the root of your application.
  // @override
  // Widget build(BuildContext context) {
  //   return const MaterialApp(
  //     title: 'TRAVALONG',
  //     home: HomePage(),
  //   );
  // }

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: StreamBuilder<User?>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return const HomePage();
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text("Something went wrong..."),
                  );
                } else {
                  return const StartScreen();
                }
              }),
        ),
      );
}
