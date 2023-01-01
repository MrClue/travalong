import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:travalong/data/model/user.dart';
import 'package:travalong/logic/controller/firebase_controller.dart';
import 'package:travalong/logic/controller/connections_controller.dart';
import 'package:travalong/presentation/resources/widgets/atoms/back_arrow.dart';
import 'package:travalong/presentation/resources/widgets/atoms/safe_scaffold.dart';
import 'package:travalong/presentation/resources/widgets/molecules/theme_topbar.dart';
import 'package:travalong/presentation/screens/search/widgets/view_profile_box.dart';

FirebaseController fController = FirebaseController();
ConnectionsController conController = ConnectionsController();

class ViewProfile extends StatefulWidget {
  final String id;
  final String name;
  final int age;
  final String city;
  final String country;
  final String bio;
  final List<dynamic> interests;
  final int sharedInterests;
  final String userImage;

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
    required this.userImage,
  });

  @override
  State<ViewProfile> createState() => _ViewProfileState();
}

class _ViewProfileState extends State<ViewProfile> {
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
                        event.docs.any((element) => element.id == widget.id),
                  ),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var currentUserDoc = (snapshot.data as QuerySnapshot)
                      .docs
                      .firstWhere(
                          (element) => element.id == fController.userID);

                  var otherUserDoc = (snapshot.data as QuerySnapshot)
                      .docs
                      .firstWhere((element) => element.id == widget.id);

                  debugPrint(widget.id); // selected users uid (other user)

                  return ViewProfileBox(
                    name: otherUserDoc.get(UserData.name),
                    age: otherUserDoc.get(UserData.age),
                    bio: otherUserDoc.get(UserData.bio),
                    city: otherUserDoc.get(UserData.city),
                    country: otherUserDoc.get(UserData.country),
                    interests: const ['I1', 'I2', 'I3'],
                    sharedInterests: widget.sharedInterests,
                    userImage: widget.userImage.toString(),
                    onTapped: () {
                      // * Updates connectionList. If UID already exist, then do nothing

                      // for current user
                      if ((currentUserDoc.data() as Map<String, dynamic>)
                          .containsKey(UserData.connectionsList)) {
                        // Updates users current connections
                        conController.updateUserConnections(widget.id);
                      } else {
                        // Sets users connectionList
                        conController.setUserConnections(widget.id);
                      }

                      // for other user
                      if ((otherUserDoc.data() as Map<String, dynamic>)
                          .containsKey(UserData.connectionsList)) {
                        // Updates other-users current connections
                        conController.updateOtherUserConnections(widget.id);
                      } else {
                        // Sets other-users connectionList
                        conController.setOtherUserConnections(widget.id);
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
