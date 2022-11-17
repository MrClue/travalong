import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class SignUpScreen extends StatefulWidget{
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  int _selectedIndex = 0;

  Color textFieldFormColor = Color(0xFFF5F8FD);
  Color buttonColor = Color(0xFF2ABAFF);
  Color strokeColor = Color(0xFFE8F0FF);

  Widget _renderSignUp() {
    return SlidingUpPanel(
      body: const Center(
      ),
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20.0),
        topRight: Radius.circular(20.0),
      ),
      defaultPanelState: PanelState.OPEN,
      minHeight: 600,
      maxHeight: 600,
      isDraggable: false,
      panel: Container(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget> [
            Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Sign Up",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    FloatingActionButton.small(
                      backgroundColor: buttonColor,
                      child: Icon(Icons.close_rounded, color: Colors.white, weight: 2,),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                )
            ),
            const SizedBox(height: 60),
            TextField(
              controller: _nameController,
              autofocus: false,
              autocorrect: false,
              enableSuggestions: false,
              decoration: InputDecoration(
                filled: true,
                fillColor: textFieldFormColor,
                labelText: 'Password',
                floatingLabelStyle: TextStyle(color: Colors.black),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: strokeColor),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: buttonColor),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: strokeColor),
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
            ),
            SizedBox(height: 20.0,),
            TextField(
              controller: _emailController,
              autofocus: false,
              autocorrect: false,
              enableSuggestions: false,
              decoration: InputDecoration(
                filled: true,
                fillColor: textFieldFormColor,
                labelText: 'Email',
                floatingLabelStyle: TextStyle(color: Colors.black),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: strokeColor),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: buttonColor),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: strokeColor),
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
            ),
            SizedBox(height: 20.0,),
            TextField(
              controller: _passwordController,
              obscureText: true,
              autofocus: false,
              autocorrect: false,
              enableSuggestions: false,
              decoration: InputDecoration(
                filled: true,
                fillColor: textFieldFormColor,
                labelText: 'Password',
                floatingLabelStyle: TextStyle(color: Colors.black),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: strokeColor),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: buttonColor),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: strokeColor),
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            TextField(
              controller: _passwordController,
              obscureText: true,
              autofocus: false,
              autocorrect: false,
              enableSuggestions: false,
              decoration: InputDecoration(
                filled: true,
                fillColor: textFieldFormColor,
                labelText: 'Repeat Password',
                floatingLabelStyle: TextStyle(color: Colors.black),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: strokeColor),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: buttonColor),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: strokeColor),
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
            ),
            SizedBox(height: 40.0,),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: FloatingActionButton.extended(
                backgroundColor: buttonColor,
                label: const Text("Sign Up",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0
                  ),
                ),
                onPressed: () async {
                  final email = _emailController.text;
                  final password = _passwordController.text;

                  if (email.isEmpty || password.isEmpty) {
                    showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: const Text('Error'),
                          content: const Text(
                              'Please enter your email and password'),
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
                  //_signIn();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }


@override
Widget build(BuildContext context) {
  _emailController.text = "";

  return Scaffold(
    //extendBodyBehindAppBar: true,
    //resizeToAvoidBottomInset: false,
    body: IndexedStack(
      index: _selectedIndex,
      children: [
        //_renderSignIn(),
        _renderSignUp(),
      ],
    ),
  );
}
}