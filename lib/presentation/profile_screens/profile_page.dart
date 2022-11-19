import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travalong/logic/user_data.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = UserData.dummyUser;

    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: 215,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                spreadRadius: 0,
                blurRadius: 4,
                offset: const Offset(0, 4), // changes position of shadow
              )
            ],
            color: Colors.white, // TODO change to actual theme color
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(15.0),
              bottomRight: Radius.circular(15.0),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment:
                CrossAxisAlignment.center, // ! maybee not needed
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
                  Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            user.name,
                            style: GoogleFonts.poppins(
                                fontSize: 30, fontWeight: FontWeight.w700),
                          ),
                          Text(
                            ", ${user.age}",
                            style: GoogleFonts.poppins(
                                fontSize: 24, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      Text(
                        "${user.city}, ${user.country}",
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
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
                          fontWeight: FontWeight.w400,
                        ),
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
                          fontWeight: FontWeight.w400,
                        ),
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
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
