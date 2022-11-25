import 'package:flutter/material.dart';
import 'package:travalong/presentation/profile_screens/profile_page.dart';
//import 'package:travalong/presentation/profile_screens/profile_page.dart';
import 'package:travalong/presentation/start_screens/start_screen.dart';

void main() {
  runApp(const TravalongApp());
}

class TravalongApp extends StatelessWidget {
  const TravalongApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'TRAVALONG',
      home:
          ProfilePage(), // ! route that is displayed first when app starts (unless "initialRoute" is specified)
    );
  }
}
