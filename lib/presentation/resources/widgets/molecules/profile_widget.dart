import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travalong/presentation/resources/colors.dart';
import 'package:travalong/logic/services/database_service.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({
    Key? key,
    //required this.user,
  }) : super(key: key);

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

var collection = FirebaseFirestore.instance.collection('users');

class _ProfileWidgetState extends State<ProfileWidget> {
  String? docId = FirebaseAuth.instance.currentUser?.uid;

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
                    children: [
                      Row(
                        children: [
                          // ! get name from Firabase Firestore
                          StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                            stream:
                                collection.doc(docId.toString()).snapshots(),
                            builder: (_, snapshot) {
                              if (snapshot.hasError) {
                                return Text('Error = ${snapshot.error}');
                              }
                              if (snapshot.hasData) {
                                var output = snapshot.data!.data();
                                var value = output!['name']; // <-- Your value
                                return Text(
                                  '$value',
                                  style: GoogleFonts.poppins(
                                      fontSize: 30,
                                      fontWeight: FontWeight.w700,
                                      height: 0),
                                  textAlign: TextAlign.left,
                                );
                              }
                              return const Center(
                                  child: CircularProgressIndicator());
                            },
                          ),
                          Text(
                            style: GoogleFonts.poppins(
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                                color: TravalongColors.secondary_text_bright,
                                height: 0),
                            textAlign: TextAlign.left,
                            ", 26",
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
                        "Odense, Denmark",
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
