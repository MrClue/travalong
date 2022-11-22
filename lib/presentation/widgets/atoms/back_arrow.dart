import 'package:flutter/material.dart';

class BackArrow extends StatelessWidget{
  const BackArrow({super.key});

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: () {
      Navigator.pop(context);
    },
    child: Icon(
      size: 25,
      Icons.arrow_back_ios,
      color: Colors.black54,
    ),
  );
}