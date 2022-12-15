import 'package:flutter/material.dart';
import 'package:travalong/presentation/resources/colors.dart';

import '../../resources/widgets/molecules/slideup_widget.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        backgroundColor: TravalongColors.primary_30,
        body: SlideUpWidget(),
      ),
    );
  }
}
