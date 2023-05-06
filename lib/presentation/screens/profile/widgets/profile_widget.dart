import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travalong/data/model/user.dart';
import 'package:travalong/logic/controller/firebase_controller.dart';
import 'package:travalong/presentation/resources/colors.dart';
import 'package:travalong/presentation/resources/widgets/theme/theme_text.dart';

import '../../../../logic/services/storage_service.dart';
import '../profile_page.dart';

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
  StorageService storageService = StorageService();
  String _name = "";
  String _age = "";
  String _userLocation = "";
  String _connections = "";
  String _travelGoals = "";
  List<String>? conList;
  XFile? _image;

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
                CircleAvatar(
                  radius: 50,
                  backgroundColor:
                      _image != null ? null : TravalongColors.secondary_10,
                  backgroundImage:
                      _image != null ? FileImage(File(_image!.path)) : null,
                  child: IconButton(
                    icon: const Icon(Icons.camera_alt),
                    onPressed: () async {
                      final pickedFile = await storageService.getImage(
                        source: ImageSource.gallery,
                        userId: fController.userID,
                      );
                      setState(() {
                        if (pickedFile != null) {
                          _image = pickedFile;
                        } else {
                          debugPrint('No image selected.');
                        }
                      });
                      final fileName = path.basename(_image!.path);
                      storageService.uploadImage(
                        fController.userID,
                        _image!,
                        fileName,
                      );
                      debugPrint('Image btn pressed: $fileName');
                    },
                  ),
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
                            .doc(fController.userID)
                            .snapshots(),
                        builder: (context,
                            AsyncSnapshot<DocumentSnapshot> snapshot) {
                          if (!snapshot.hasData || snapshot.data == null) {
                            return const Text('Loading...');
                          }

                          _name = snapshot.data!.get(UserData.name).toString();
                          _age = snapshot.data!.get(UserData.age).toString();

                          _userLocation =
                              "${snapshot.data![UserData.city]}, ${snapshot.data![UserData.country]}";

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
                stream: fController.usersCollection
                    .doc(fController.userID)
                    .snapshots(),
                builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (!snapshot.hasData || snapshot.data == null) {
                    return const Text('Loading...');
                  }

                  List<String> conList = List<String>.from(snapshot.data!
                      .get(UserData.connectionsList) as List<dynamic>);

                  _connections = conList.length.toString();

                  // updates users collections count
                  if (snapshot.hasData) {
                    fController.setDocFieldData(
                        UserData.connections, _connections);
                  }

                  // * get travel goals
                  _travelGoals = snapshot.data!
                      .get(UserData.travelgoals)
                      .length
                      .toString();

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
                            storageService.userImages.length.toString(),
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
                            _travelGoals,
                            style: GoogleFonts.poppins(
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "Travel Goals",
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
