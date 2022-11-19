import 'package:flutter/material.dart';

class Subtext extends StatelessWidget {
  final String text;

  const Subtext({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) => Text(text,
    style: const TextStyle(
      color: Colors.black45,
      fontWeight: FontWeight.bold,
      fontSize: 14
    ),
  );

}