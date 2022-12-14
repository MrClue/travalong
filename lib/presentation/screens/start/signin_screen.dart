import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travalong/logic/services/auth_service.dart';
import 'package:travalong/presentation/resources/colors.dart';

final AuthService authService = AuthService();

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  Widget _renderSignIn() {
    return Container(
      decoration: const BoxDecoration(
        color: TravalongColors.neutral_60,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Sign In",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                FloatingActionButton.small(
                  heroTag: "close_btn1",
                  backgroundColor: TravalongColors.secondary_10,
                  child: const Icon(
                    Icons.close_rounded,
                    color: TravalongColors.neutral_60,
                    //weight: 2,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            const SizedBox(height: 40),
            TextFormField(
              controller: _emailController,
              autofocus: false,
              autocorrect: false,
              enableSuggestions: false,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (email) =>
                  email != null && !EmailValidator.validate(email)
                      ? 'Enter a valid email'
                      : null,
              decoration: InputDecoration(
                filled: true,
                fillColor: TravalongColors.primary_30,
                labelText: 'Email',
                floatingLabelStyle: const TextStyle(color: Colors.black),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                      color: TravalongColors.primary_30_stroke),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: TravalongColors.secondary_10),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(
                      color: TravalongColors.primary_30_stroke),
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              autofocus: false,
              autocorrect: false,
              enableSuggestions: false,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) => value != null && value.length < 6
                  ? 'Password must be min. 6 characters'
                  : null,
              decoration: InputDecoration(
                filled: true,
                fillColor: TravalongColors.primary_30,
                labelText: 'Password',
                floatingLabelStyle: const TextStyle(color: Colors.black),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                      color: TravalongColors.primary_30_stroke),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: TravalongColors.secondary_10),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(
                      color: TravalongColors.primary_30_stroke),
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
            ),
            const SizedBox(height: 40.0),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: FloatingActionButton.extended(
                heroTag: "sign_in_btn2",
                backgroundColor: TravalongColors.secondary_10,
                label: const Text(
                  "Sign In",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0),
                ),
                onPressed: () async {
                  final email = _emailController.text;
                  final password = _passwordController.text;

                  if (email.isEmpty || password.isEmpty) {
                    showCupertinoDialog(
                        context: context,
                        builder: (_) => CupertinoAlertDialog(
                              title: const Text('Fill in your user details'),
                              content: const Text(
                                  'Inorder to sign in, you must fill in the details'),
                              actions: [
                                TextButton(
                                  child: const Text('OK'),
                                  onPressed: () =>
                                      Navigator.of(context, rootNavigator: true)
                                          .pop('dialog'),
                                )
                              ],
                            ));
                    return;
                  }

                  try {
                    authService.signIn(
                        context, _emailController, _passwordController);
                  } catch (e) {
                    return;
                  }
                },
              ),
            ),
            const SizedBox(
              height: 40.0,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    return Padding(
      padding: mediaQueryData.viewInsets,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: _renderSignIn(),
      ),
    );
  }
}
