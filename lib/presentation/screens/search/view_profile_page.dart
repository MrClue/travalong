import 'package:flutter/material.dart';
import 'package:travalong/presentation/resources/widgets/atoms/back_arrow.dart';
import 'package:travalong/presentation/resources/widgets/atoms/safe_scaffold.dart';
import 'package:travalong/presentation/resources/widgets/molecules/theme_topbar.dart';

class ViewProfile extends StatelessWidget {
  const ViewProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeScaffold(
      topbar: ThemeTopBar(
        title: "View Profile",
        enableCustomButton: false,
        backArrow: const BackArrow(),
      ),
      child: Container(),
    );
  }
}
