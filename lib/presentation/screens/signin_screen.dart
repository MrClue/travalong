import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class SignInScreen extends StatefulWidget{
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Color textFieldFormColor = Color(0xFFF5F8FD);
  Color buttonColor = Color(0xFF2ABAFF);
  Color strokeColor = Color(0xFFE8F0FF);

  int _selectedIndex = 0;

  Widget _renderSignIn() {
    return SlidingUpPanel(
      body: const Center(
      ),
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20.0),
        topRight: Radius.circular(20.0),
      ),
      defaultPanelState: PanelState.OPEN,
      minHeight: 400,
      maxHeight: 400,
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
                    Text("Sign In",
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
            SizedBox(
              height: 20.0,
            ),
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
            const SizedBox(height: 40.0),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: FloatingActionButton.extended(
                backgroundColor: buttonColor,
                label: const Text("Sign In",
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
            _renderSignIn(),
            //_renderSignUp(),
          ],
        ),
    );
  }
}