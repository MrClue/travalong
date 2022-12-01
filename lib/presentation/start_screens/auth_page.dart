import 'package:flutter/material.dart';
import 'package:travalong/presentation/screens.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPage();
}

class _AuthPage extends State<AuthPage> {
  bool isSignin = true;

  @override
  Widget build(BuildContext context) =>
      isSignin ? SignInScreen() : SignUpScreen();

  void toggle() => setState(() {
        isSignin = !isSignin;
      });
}
