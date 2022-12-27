import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travalong/data/model/user.dart';
import 'package:travalong/logic/controller/firebase_controller.dart';
import 'package:travalong/presentation/resources/colors.dart';
import 'package:travalong/presentation/resources/widgets/atoms/theme_text.dart';

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
  String _name = "";
  String _age = "";
  String _userLocation = "";
  String _connections = "";
  List<String>? conList;

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
                      StreamBuilder(
                        stream: fController.usersCollection
                            .snapshots()
                            .takeWhile((event) => event.docs
                                .any((d) => d.id == fController.userID)),
                        builder: (context, AsyncSnapshot snapshot) {
                          if (!snapshot.hasData || snapshot.data == null) {
                            return const Text('Loading...');
                          }

                          var userDocument = (snapshot.data as QuerySnapshot)
                              .docs
                              .firstWhere((d) => d.id == fController.userID);

                          _name = userDocument.get(UserData.name).toString();
                          _age = userDocument.get(UserData.age).toString();

                          var city = userDocument.get(UserData.city);
                          var country = userDocument.get(UserData.country);
                          _userLocation = "$city, $country";

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // * name + age
                              Row(
                                children: [
                                  ConstrainedBox(
                                    constraints: const BoxConstraints(
                                      maxWidth: 225 - 40, // (- age maxWidth)
                                    ),
                                    // 30, w700,
                                    child: ThemeText(
                                      textString: '$_name, ',
                                      maxLines: 1,
                                      fontSize: 30,
                                      fontWeight: FontWeight.w700,
                                      textColor:
                                          TravalongColors.primary_text_bright,
                                    ),
                                  ),
                                  ConstrainedBox(
                                    constraints:
                                        const BoxConstraints(maxWidth: 50),
                                    child: ThemeText(
                                      textString: _age,
                                      maxLines: 1,
                                      fontSize: 26,
                                      fontWeight: FontWeight.w500,
                                      textColor:
                                          TravalongColors.primary_text_bright,
                                    ),
                                  ),
                                ],
                              ),
                              // * city + country
                              ConstrainedBox(
                                constraints:
                                    const BoxConstraints(maxWidth: 225),
                                child: ThemeText(
                                  textString: _userLocation, // city, country,
                                  maxLines: 1,
                                  fontSize: 22,
                                  height: 1,
                                  fontWeight: FontWeight.w500,
                                  textColor:
                                      TravalongColors.secondary_text_bright,
                                ),
                              ),
                            ],
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
            StreamBuilder(
                stream: fController.usersCollection.snapshots().takeWhile(
                    (event) =>
                        event.docs.any((d) => d.id == fController.userID)),
                builder: (context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData || snapshot.data == null) {
                    return const Text('Loading...');
                  }

                  var userDocument = (snapshot.data as QuerySnapshot)
                      .docs
                      .firstWhere((d) => d.id == fController.userID);

                  List<String> conList = List<String>.from(
                      userDocument.get('connectionsList') as List<dynamic>);

                  _connections = conList.length.toString();

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text(
                            _connections,
                            style: GoogleFonts.poppins(
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                                color: TravalongColors.secondary_text_bright),
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
                            "3", //!TO DO
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
                  );
                })
          ],
        ),
      ),
    );
  }
}
