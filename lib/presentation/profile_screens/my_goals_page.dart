import "package:flutter/material.dart";
import 'package:travalong/presentation/resources/widgets/atoms/safe_scaffold.dart';

import '../resources/widgets/molecules/topbar.dart';

class MyGoalsPage extends StatelessWidget {
  const MyGoalsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeScaffoldNoNavbar(
      topbar: const TopBar(title: "My Goals"),
      child: Container(),
    );
  }
}
