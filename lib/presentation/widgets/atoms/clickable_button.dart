import 'package:flutter/material.dart';

class ClickButton extends StatelessWidget {
  final String text;

  const ClickButton({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) => SizedBox(
    width: 400,
    height: 50,
    child: FloatingActionButton.extended(
      onPressed: () {
        // Add your onPressed code here!
      },
      label:Text(text,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );

}