import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travalong/logic/user.dart';
import "package:travalong/presentation/resources/colors.dart";

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width, //double.infinity,
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
          //crossAxisAlignment: CrossAxisAlignment.center, // ! maybee not needed
          children: [
            // * top row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(user.imagePath),
                ),
                const SizedBox(
                  width: 15.0,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            style: GoogleFonts.poppins(
                                fontSize: 30,
                                fontWeight: FontWeight.w700,
                                height: 0),
                            textAlign: TextAlign.left,
                            user.name,
                          ),
                          Text(
                            style: GoogleFonts.poppins(
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                                color: TravalongColors.secondary_text_bright,
                                height: 0),
                            textAlign: TextAlign.left,
                            ", ${user.age}",
                          ),
                        ],
                      ),
                      Text(
                        // TODO: Fix overflow issues
                        style: GoogleFonts.poppins(
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                            color: TravalongColors.secondary_text_bright,
                            height: 1),
                        textAlign: TextAlign.left,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        "${user.city}, ${user.country}",
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
                      "${user.connections}",
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
                      "${user.media}",
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
                      "${user.goalsCompleted}%",
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
