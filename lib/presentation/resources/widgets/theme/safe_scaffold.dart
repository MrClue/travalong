import 'package:flutter/material.dart';
import 'package:travalong/presentation/resources/colors.dart';

// ! Includes: navbar, appbar
class SafeScaffold extends StatelessWidget {
  final PreferredSizeWidget? topbar;
  final Widget? navbar;
  final Widget child;
  final bool resizeToAvoidBottomInset;

  const SafeScaffold({
    super.key,
    this.resizeToAvoidBottomInset = false,
    this.topbar,
    this.navbar,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:
          resizeToAvoidBottomInset, // "false" prevents keyboard overflow
      backgroundColor: TravalongColors.neutral_60,

      appBar: topbar,
      bottomNavigationBar: navbar,
      body: SafeArea(child: child),
    );
  }
}
