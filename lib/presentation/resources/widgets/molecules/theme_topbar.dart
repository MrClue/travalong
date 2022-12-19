import 'package:flutter/material.dart';
import 'package:travalong/presentation/resources/colors.dart';
import 'package:travalong/presentation/resources/widgets/atoms/theme_text.dart';

class ThemeTopBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget backArrow;
  final bool enableCustomButton;
  final Widget customButtonWidget;

  const ThemeTopBar({
    Key? key,
    required this.title,
    required this.backArrow,
    required this.enableCustomButton,
    this.customButtonWidget = const Text("btn"),
  }) : super(key: key);

  double get topbarHeight => 65; // is method to avoid having it in constructor

  @override
  Size get preferredSize => Size.fromHeight(topbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: TravalongColors.neutral_60,
      toolbarHeight: topbarHeight,
      elevation: 0,
      shape: const Border(
        bottom: BorderSide(
          color: Color.fromRGBO(0, 0, 0, 0.25),
          width: 1.5,
        ),
      ),
      //automaticallyImplyLeading: false, // disables default back arrow
      leading: backArrow,
      title: ThemeText(
        textString: title,
        fontSize: 24,
        fontWeight: FontWeight.w500,
        textColor: Colors.black,
      ),
      centerTitle: true,
      actions: <Widget>[
        if (enableCustomButton == true) customButtonWidget,
      ],
    );
  }
}
