import 'package:flutter/material.dart';
import 'package:travalong/presentation/screens/start_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App name',
      theme: ThemeData(
        primaryColor: Colors.grey,
        primarySwatch: Colors.blue,
      ),
      home: StartScreen(),
    );
  }
}
