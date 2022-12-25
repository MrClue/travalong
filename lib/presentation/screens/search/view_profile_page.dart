import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travalong/data/model/user.dart';
import 'package:travalong/logic/controller/firebase_controller.dart';
import 'package:travalong/logic/services/database_service.dart';
import 'package:travalong/presentation/resources/widgets/atoms/back_arrow.dart';
import 'package:travalong/presentation/resources/widgets/atoms/safe_scaffold.dart';
import 'package:travalong/presentation/resources/widgets/molecules/theme_topbar.dart';
import 'package:travalong/presentation/screens/search/widgets/view_profile_box.dart';

FirebaseController fController = FirebaseController();

class ViewProfile extends StatefulWidget {
  final String? id;
  final String name;
  final int age;
  final String city;
  final String country;
  final String bio;
  final List<dynamic> interests;
  ViewProfile(
      {super.key,
      this.id,
      required this.name,
      required this.age,
      required this.city,
      required this.country,
      required this.bio,
      required this.interests});

  @override
  State<ViewProfile> createState() => _ViewProfileState();
}

class _ViewProfileState extends State<ViewProfile> {
  var id;
  var name;

  @override
  Widget build(BuildContext context) {
    return SafeScaffold(
      topbar: ThemeTopBar(
        title: "View Profile",
        enableCustomButton: false,
        backArrow: const BackArrow(),
      ),
      child: Container(
        margin: const EdgeInsets.all(8),
        child: Center(
          child: StreamBuilder(
              stream: fController.usersCollection.snapshots().takeWhile(
                  (event) =>
                      event.docs.any((element) => element.id == widget.id)),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var userDocument = (snapshot.data as QuerySnapshot)
                      .docs
                      .firstWhere((element) => element.id == widget.id);
                  print(widget.id); // DEBUG TO CHECK CORRECT USER
                  return ViewProfileBox(
                    name: userDocument.get(UserData.name),
                    age: '25',
                    bio: 'BIO',
                    city: 'CITY',
                    country: 'COUNTRY',
                    interests: ['I1', 'I2', 'I3'],
                  );
                }
                return Container();
              }),
        ),
      ),
    );
  }
}