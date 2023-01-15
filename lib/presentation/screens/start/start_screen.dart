import 'package:flutter/material.dart';

import '../../resources/widgets/theme/safe_scaffold.dart';
import 'widgets/slideup_widget.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  Widget build(BuildContext context) {
    return const SafeScaffold(
      child: SlideUpWidget(),
    );
  }
}
