import 'package:flutter/material.dart';
import 'package:travalong/presentation/widgets/molecules/topbar.dart';
import 'package:travalong/presentation/screens/start_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
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
