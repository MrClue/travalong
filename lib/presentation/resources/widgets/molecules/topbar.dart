import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travalong/presentation/resources/widgets/atoms/back_arrow.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const TopBar({Key? key, required this.title, style}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AppBar(
        leading: const BackArrow(),
        centerTitle: true,
        title: Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 18,
            color: Colors.black54,
            fontWeight: FontWeight.bold,
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
