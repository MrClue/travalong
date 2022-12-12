import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travalong/presentation/resources/colors.dart';

class TopBarWithAction extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final Widget goToPage;
  final Widget? leading;

  const TopBarWithAction({
    Key? key,
    required this.title,
    required this.goToPage,
    this.leading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: leading,
      leadingWidth: 100,
      centerTitle: true,
      title: Text(
        title as String,
        style: GoogleFonts.poppins(
          fontSize: 24,
          color: Colors.black54,
          fontWeight: FontWeight.normal,
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
  final String? title;
  final Widget? goToPage;
  final Widget? leading;

  const TopBar({
    Key? key,
    required this.title,
    this.goToPage,
    this.leading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: leading,
      leadingWidth: 100,
      centerTitle: true,
      title: Text(
        title!,
        style: GoogleFonts.poppins(
          fontSize: 24,
          color: Colors.black54,
          fontWeight: FontWeight.normal,
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

class TopBarChat extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final goToPage;
  final Widget? leading;

  const TopBarChat({
    Key? key,
    required this.title,
    required this.goToPage,
    this.leading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: leading,
      //leadingWidth: 80,
      centerTitle: true,
      title: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 24,
          color: Colors.black54,
          fontWeight: FontWeight.normal,
          letterSpacing: 2,
          decoration: TextDecoration.none,
        ),
      ),
      backgroundColor: Colors.white,
      elevation: 0.0,
      actions: <Widget>[
        IconButton(
          icon: const Icon(
            Icons.edit_outlined,
            color: TravalongColors.secondary_10,
          ),
          onPressed: () {
            goToPage();
          },
        ),
      ],
    );
  }

  static final _topBarChat = AppBar();

  @override
  Size get preferredSize => _topBarChat.preferredSize;
}

class TopBarChatName extends StatelessWidget implements PreferredSizeWidget {
  final Widget? goToPage;
  final Widget? leading;
  final Widget title;

  const TopBarChatName({
    Key? key,
    this.goToPage,
    this.leading,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: leading,
      centerTitle:
          true, // ! Does not affect the centerTitle of a row in a widget...
      title: title,
      backgroundColor: Colors.white,
      elevation: 0.0,
    );
  }

  static final _topBarChatName = AppBar();

  @override
  Size get preferredSize => _topBarChatName.preferredSize;
}
