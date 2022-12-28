import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travalong/data/model/user.dart';
import 'package:travalong/logic/controller/firebase_controller.dart';
import 'package:travalong/presentation/resources/widgets/atoms/back_arrow.dart';
import 'package:travalong/presentation/resources/widgets/atoms/safe_scaffold.dart';
import 'package:travalong/presentation/resources/widgets/molecules/theme_topbar.dart';
import 'package:travalong/presentation/screens/search/widgets/view_profile_box.dart';

FirebaseController fController = FirebaseController();

class ViewProfile extends StatefulWidget {
  final String id;
  final String name;
  final int age;
  final String city;
  final String country;
  final String bio;
  final List<dynamic> interests;
  final int sharedInterests;
  const ViewProfile({
    super.key,
    required this.id,
    required this.name,
    required this.age,
    required this.city,
    required this.country,
    required this.bio,
    required this.interests,
    required this.sharedInterests,
  });

  @override
  State<ViewProfile> createState() => _ViewProfileState();
}

class _ViewProfileState extends State<ViewProfile> {
  //var id;
  //var name;
  //var connectionsList;

  @override
  Widget build(BuildContext context) {
    return SafeScaffold(
      topbar: const ThemeTopBar(
        title: "View Profile",
        enableCustomButton: false,
        backArrow: BackArrow(),
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
                  var otherUserDocument = (snapshot.data as QuerySnapshot)
                      .docs
                      .firstWhere(
                          (element) => element.id == fController.userID);
                  debugPrint(widget.id); // DEBUG TO CHECK CORRECT USER
                  return ViewProfileBox(
                    name: userDocument.get(UserData.name),
                    age: userDocument.get(UserData.age),
                    bio: userDocument.get(UserData.bio),
                    city: 'CITY',
                    country: 'COUNTRY',
                    interests: const ['I1', 'I2', 'I3'],
                    sharedInterests: widget.sharedInterests,
                    onTapped: () {
                      // ** Will update the connectionList. Also if UID already exist, then do nothing
                      // ! Add connection in current users list
                      if ((userDocument.data() as Map<String, dynamic>)
                          .containsKey('connectionsList')) {
                        fController.usersCollection
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .update({
                          'connectionsList': FieldValue.arrayUnion([widget.id]),
                        }).then(
                                (value) => debugPrint(
                                    "User connection successfully updated!"),
                                onError: (e) => debugPrint(
                                    "Error updating user connections $e"));
                      } else {
                        // ! Add connection in current users list
                        fController.usersCollection
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .set({
                          'connectionsList': FieldValue.arrayUnion([widget.id]),
                        }, SetOptions(merge: true)).then(
                                (value) => debugPrint(
                                    "New user connections successfully set!"),
                                onError: (e) => debugPrint("Error if else $e"));
                      }
                      // ! Add connection in other users list
                      if ((otherUserDocument.data() as Map<String, dynamic>)
                          .containsKey('connectionsList')) {
                        fController.usersCollection.doc(widget.id).update({
                          'connectionsList': FieldValue.arrayUnion(
                              [FirebaseAuth.instance.currentUser!.uid]),
                        }).then(
                            (value) => debugPrint(
                                "Other user connection successfully updated!"),
                            onError: (e) => debugPrint(
                                "Error updating other user connections $e"));
                      } else {
                        // ! Add connection in other users list
                        fController.usersCollection.doc(widget.id).set({
                          'connectionsList': FieldValue.arrayUnion(
                              [FirebaseAuth.instance.currentUser!.uid]),
                        }, SetOptions(merge: true)).then(
                            (value) => debugPrint(
                                "Other new user connections successfully set!"),
                            onError: (e) => debugPrint("Error if else $e"));
                      }
                    },
                  );
                }
                return Container();
              }),
        ),
      ),
    );
  }
}
