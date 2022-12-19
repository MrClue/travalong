import 'package:flutter/material.dart';
import 'package:travalong/presentation/resources/colors.dart';
import 'package:travalong/presentation/resources/widgets/atoms/theme_text.dart';

class ThemeTopBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  Widget? backArrow;
  final bool enableCustomButton;
  final Widget customButtonWidget;

  ThemeTopBar({
    Key? key,
    required this.title,
    this.backArrow,
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
          color: TravalongColors.primary_30_stroke,
          width: 1.0,
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
