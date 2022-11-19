import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget{
  final String title;

  const TopBar({Key? key, required this.title, style}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AppBar(
        centerTitle: true,
        title: Text(title,
          style: GoogleFonts.poppins(
            fontSize: 18,
            color: Colors.black45,
            fontWeight: FontWeight.w500,
            letterSpacing: 2,
            decoration: TextDecoration.none,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
    );
  }

  static final _appBar = AppBar();
  @override
  Size get preferredSize => _appBar.preferredSize;

}
