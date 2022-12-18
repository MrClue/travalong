import 'package:flutter/material.dart';

import '../../colors.dart';

class ThemeContainer extends StatelessWidget {
  final double height, width;
  final bool customWidth;
  final Widget child;

  const ThemeContainer({
    super.key,
    required this.height,
    required this.child,
    this.customWidth = false,
    this.width = 100,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: customWidth ? width : MediaQuery.of(context).size.width - 28,
      height: height,
      padding: const EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
        color: TravalongColors.primary_30,
        border: Border.all(
          color: TravalongColors.primary_30_stroke,
          width: 1.5,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      ),
      child: child,
    );
  }
}

class ThemeContainerAlt extends StatelessWidget {
  final double height;
  final Widget child;

  const ThemeContainerAlt(
      {super.key, required this.height, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 30, // 28
      height: height,
      padding: const EdgeInsets.only(left: 10, right: 10),
      decoration: const BoxDecoration(
        color: Colors.transparent,
        border: Border.symmetric(
          horizontal: BorderSide(
            color: TravalongColors.primary_30_stroke,
            width: 1.5, //1.5,
          ),
        ),
      ),
      child: child,
    );
  }
}
