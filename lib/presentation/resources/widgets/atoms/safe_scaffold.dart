import 'package:flutter/material.dart';
import 'package:travalong/presentation/resources/colors.dart';

// ! Includes: navbar, appbar
class SafeScaffold extends StatelessWidget {
  final PreferredSizeWidget? topbar;
  final Widget? navbar;
  final Widget child;

  const SafeScaffold({
    super.key,
    this.topbar,
    this.navbar,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // prevents keyboard overflow
      backgroundColor: TravalongColors.neutral_60,

      appBar: topbar,
      bottomNavigationBar: navbar,
      body: SafeArea(child: child),
    );
  }
}
/*
// ! Includes: topbar
class SafeScaffoldNoNavbar extends StatelessWidget {
  final PreferredSizeWidget? topbar;
  final Widget child;

  const SafeScaffoldNoNavbar({super.key, this.topbar, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // prevents keyboard overflow
      backgroundColor: TravalongColors.neutral_60,
      appBar: topbar,
      body: SafeArea(child: child),
    );
  }
}

// ! Includes: navbar
class SafeScaffoldNoTopbar extends StatelessWidget {
  final Widget child, navbar;

  const SafeScaffoldNoTopbar(
      {super.key, required this.navbar, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // prevents keyboard overflow
      backgroundColor: TravalongColors.neutral_60,

      bottomNavigationBar: navbar,
      body: SafeArea(child: child),
    );
  }
}

// ! Includes: only scaffold
class SafeScaffoldPure extends StatelessWidget {
  final Widget child;

  const SafeScaffoldPure({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // prevents keyboard overflow
      backgroundColor: TravalongColors.neutral_60,

      body: SafeArea(child: child),
    );
  }
}
*/