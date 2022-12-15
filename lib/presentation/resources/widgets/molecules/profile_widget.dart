import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travalong/logic/controller/firebase_controller.dart';
import 'package:travalong/presentation/resources/colors.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  // * creates instance of firebase_controller class
  FirebaseController fController = FirebaseController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 215,
      decoration: BoxDecoration(
        color: TravalongColors.neutral_60,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(15.0),
          bottomRight: Radius.circular(15.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            spreadRadius: 0, // -2
            blurRadius: 3, // 4
            offset: const Offset(0, 5), // changes position of shadow
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // * top row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(
                      'https://pfpmaker.com/_nuxt/img/profile-3-1.3e702c5.png'),
                ),
                const SizedBox(
                  width: 15.0,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          FutureBuilder(
                            future: fController.getDocFieldData('name'),
                            builder: (context, snapshot) {
                              return Center(
                                child: AutoSizeText(
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: GoogleFonts.poppins(
                                      fontSize: 30,
                                      fontWeight: FontWeight.w700,
                                      height: 0),
                                  textAlign: TextAlign.left,
                                  snapshot.data.toString() + ' ',
                                ),
                              );
                            },
                          ),
                          FutureBuilder(
                            future: fController.getDocFieldData('age'),
                            builder: (context, snapshot) {
                              return Center(
                                child: AutoSizeText(
                                  style: GoogleFonts.poppins(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w500,
                                      color:
                                          TravalongColors.secondary_text_bright,
                                      height: 0),
                                  textAlign: TextAlign.left,
                                  maxLines: 1,
                                  snapshot.data.toString(),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      FutureBuilder(
                        future: fController.getDocFieldData('city'),
                        builder: (context, snapshot) {
                          return Center(
                            child: Text(
                              style: GoogleFonts.poppins(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500,
                                  color: TravalongColors.secondary_text_bright,
                                  height: 1),
                              textAlign: TextAlign.left,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              // Missing City
                              snapshot.data.toString() + ', Denmark',
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 25.0,
            ),
            // * bottom row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      "5",
                      style: GoogleFonts.poppins(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "Connections",
                      style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: TravalongColors.secondary_text_bright),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "3",
                      style: GoogleFonts.poppins(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "Shared Media",
                      style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: TravalongColors.secondary_text_bright),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "40%",
                      style: GoogleFonts.poppins(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "Goals Acheived",
                      style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: TravalongColors.secondary_text_bright),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
