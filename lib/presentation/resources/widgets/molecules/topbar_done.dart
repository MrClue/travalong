import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travalong/presentation/resources/colors.dart';

class TopBarDone extends StatelessWidget implements PreferredSizeWidget {
  const TopBarDone({
    Key? key,
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
      automaticallyImplyLeading: false, // disables default back arrow
      title: Text(
        "My Profile",
        style: GoogleFonts.poppins(
          fontSize: 24,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      ),
      centerTitle: true,
      actions: <Widget>[
        IconButton(
          constraints: const BoxConstraints.expand(width: 80),
          icon: Text(
            'Done',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: TravalongColors.secondary_10),
          ),
          onPressed: () {
            // TODO: First save all data

            //hideKeyboard(context); // hide keyboard

            Navigator.pop(context); // return to previous page
          },
        ),
      ],
    );
  }
}
