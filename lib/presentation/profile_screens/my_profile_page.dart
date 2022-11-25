import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';

import '../resources/colors.dart';

class MyProfilePage extends StatelessWidget {
  const MyProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const TopBarDone(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "About Me",
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.edit,
                        ),
                      ),
                    ],
                  ),
                  TextField(
                    maxLength: 250,
                    maxLines: 5,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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

            Navigator.pop(context); // return to previous page
          },
        ),
      ],
    );
  }
}
