import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travalong/presentation/resources/colors.dart';
import 'package:travalong/presentation/screens/screens.dart';
import 'package:travalong/logic/services/auth_service.dart';

//final FirebaseAuth _auth = FirebaseAuth.instance; // ! not used
final AuthService authService = AuthService();

final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordCheckController =
      TextEditingController();

  final formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  Widget _renderSignUp() {
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(
            color: TravalongColors.secondary_10,
          ))
        : Padding(
            padding: const EdgeInsets.only(top: 125),
            child: Container(
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
                          "Sign Up",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        FloatingActionButton.small(
                          heroTag: "close_btn2",
                          backgroundColor: TravalongColors.secondary_10,
                          child: const Icon(
                            Icons.close_rounded,
                            color: TravalongColors.neutral_60, /*weight: 2,*/
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 60),
                    // NAME
                    TextFormField(
                      controller: _nameController,
                      autofocus: false,
                      autocorrect: false,
                      enableSuggestions: false,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (name) =>
                          name == "" ? 'Enter your name' : null,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: TravalongColors.primary_30,
                        labelText: 'Name',
                        floatingLabelStyle:
                            const TextStyle(color: Colors.black),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: TravalongColors.primary_30_stroke),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: TravalongColors.secondary_10),
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
                    // EMAIL
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
                        floatingLabelStyle:
                            const TextStyle(color: Colors.black),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: TravalongColors.primary_30_stroke),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: TravalongColors.secondary_10),
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
                    // PASSWORD
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
                        floatingLabelStyle:
                            const TextStyle(color: Colors.black),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: TravalongColors.primary_30_stroke),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: TravalongColors.secondary_10),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: TravalongColors.primary_30_stroke),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    // REPEAT PASSWORD
                    TextFormField(
                      controller: _passwordCheckController,
                      obscureText: true,
                      autofocus: false,
                      autocorrect: false,
                      enableSuggestions: false,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) => value != _passwordController.text
                          ? 'Password does not match'
                          : null,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: TravalongColors.primary_30,
                        labelText: 'Repeat Password',
                        floatingLabelStyle:
                            const TextStyle(color: Colors.black),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: TravalongColors.primary_30_stroke),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: TravalongColors.secondary_10),
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
                      height: 40.0,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: FloatingActionButton.extended(
                          heroTag: "sign_up_btn2",
                          backgroundColor: TravalongColors.secondary_10,
                          label: const Text(
                            "Sign Up",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0),
                          ),
                          onPressed: () async {
                            final name = _nameController.text;
                            final email = _emailController.text;
                            final password = _passwordController.text;
                            final passwordCheck = _passwordCheckController.text;

                            if (email.isEmpty ||
                                password.isEmpty ||
                                name.isEmpty ||
                                passwordCheck != password) {
                              showCupertinoDialog(
                                context: context,
                                builder: (_) => CupertinoAlertDialog(
                                  title: const Text('Sign up failed'),
                                  content: const Text(
                                      'Please enter correct details in order to sign up'),
                                  actions: [
                                    TextButton(
                                      child: const Text('OK'),
                                      onPressed: () => Navigator.of(context,
                                              rootNavigator: true)
                                          .pop('dialog'),
                                    )
                                  ],
                                ),
                              );
                              return;
                            }
                            try {
                              signUp();
                            } on FirebaseAuthException catch (e) {
                              showCupertinoDialog(
                                context: context,
                                builder: (_) => CupertinoAlertDialog(
                                  title: const Text('Sign up failed'),
                                  content: const Text(
                                      'Failed to sign up. Try again'),
                                  actions: [
                                    TextButton(
                                        child: const Text('OK'),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        }),
                                  ],
                                ),
                              );
                            }
                          }),
                    ),
                  ],
                ),
              ),
            ),
          );
  }

  signUp() async {
    _isLoading = true;
    await authService
        .registerUser(_nameController.text, _emailController.text,
            _passwordController.text)
        .then((value) {
      if (value == true) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const ProfilePage(),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _renderSignUp();
  }
}
