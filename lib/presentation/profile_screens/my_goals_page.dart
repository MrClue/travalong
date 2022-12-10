import "package:flutter/material.dart";
import 'package:travalong/presentation/resources/widgets/atoms/back_arrow.dart';
import 'package:travalong/presentation/resources/widgets/atoms/safe_scaffold.dart';
import 'package:travalong/presentation/resources/widgets/molecules/theme_topbar.dart';

class MyGoalsPage extends StatelessWidget {
  const MyGoalsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeScaffoldNoNavbar(
      topbar: const ThemeTopBar(
        title: 'My Goals',
        backArrow: BackArrow(),
        enableCustomButton: false,
        customButtonWidget: Text(""),
      ),
      child: Container(),
    );
  }
}
