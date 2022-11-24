import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travalong/presentation/resources/colors.dart';
import 'package:travalong/presentation/resources/widgets/atoms/back_arrow.dart';

class TopBarWithAction extends StatelessWidget implements PreferredSizeWidget{
  final String title;
  final Widget goToPage;
  final Widget? leading;

  const TopBarWithAction({
    Key ? key,
    required this.title,
    required this.goToPage,
    this.leading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: leading,
      centerTitle: true,
      title: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 24,
          color: Colors.black54,
          fontWeight: FontWeight.bold,
          letterSpacing: 2,
          decoration: TextDecoration.none,
        ),
      ),
      backgroundColor: Colors.white,
      elevation: 0.0,
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.edit_outlined,
            color: TravalongColors.secondary_10,
          ),
          onPressed: (() {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => goToPage),
            );
          }),
        ),
      ],
    );
  }

  static final _topBarWithAction = AppBar();
  @override
  Size get preferredSize => _topBarWithAction.preferredSize;

}

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? goToPage;
  final Widget? leading;

  const TopBar({
    Key ? key,
    required this.title,
    this.goToPage,
    this.leading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: leading,
      centerTitle: true,
      title: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 24,
          color: Colors.black54,
          fontWeight: FontWeight.bold,
          letterSpacing: 2,
          decoration: TextDecoration.none,
        ),
      ),
      backgroundColor: Colors.white,
      elevation: 0.0,
    );
  }

    static final _topBar = AppBar();
    @override
    Size get preferredSize => _topBar.preferredSize;
  }