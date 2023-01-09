import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:travalong/data/model/user.dart';
import 'package:travalong/logic/controller/firebase_controller.dart';
import 'package:travalong/presentation/screens/screens.dart';
import 'package:travalong/presentation/screens/search/view_profile_page.dart';
import 'package:travalong/presentation/screens/search/widgets/profile_square.dart';

import '../../../../logic/search_logic/sort_users.dart';

class ResultsGrid extends StatefulWidget {
  final DateTime startDate, endDate;
  final String genderType, searchType;

  const ResultsGrid({
    super.key,
    required this.startDate,
    required this.endDate,
    required this.genderType,
    required this.searchType,
  });

  @override
  State<ResultsGrid> createState() => ResultsGridState();
}

class ResultsGridState extends State<ResultsGrid> {
  FirebaseController fController = FirebaseController();

  final String _userImage = MediaWidget.sampleImages[2];

  // TODO: skal matche søgekriterierne
  List _users = [];
  List currentUserInterests = [];
  Map<dynamic, int> sharedInterestsMap = {};

  void printStuff() {
    debugPrint("date: ${widget.startDate} - ${widget.endDate}");
    debugPrint("gender: ${widget.genderType}");
    debugPrint("searching: ${widget.searchType}");
  }

  @override
  void initState() {
    super.initState();
    //printStuff(); // ! test
    fController.getDocFieldData(UserData.interests).then((interests) {
      fController.getDocFieldData(UserData.travelgoals).then((goals) {
        // Extract the interests string between the square brackets
        String interestsString = interests.substring(1, interests.length - 1);
        String goalsString = goals.substring(1, goals.length - 1);

        String stringItems = "$interestsString, $goalsString";
        //debugPrint("stringValue: $stringValue");
        setState(() {
          currentUserInterests = stringItems.split(', ');
          debugPrint("current users interests: $currentUserInterests");
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: fController.usersCollection.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          // * Remove current user from _users list
          _users = !snapshot.hasData
              ? []
              : snapshot.data!.docs
                  .where((element) =>
                      element['uid'].toString().contains(fController.userID) ==
                      false)
                  .toList();
          //debugPrint("users: " + _users.length.toString());
          //debugPrint("selected: " + widget.genderType.toString());

          // * Sort users based on shared interests
          if (_users.isNotEmpty) {
            var result = SortUsers().initUsersList(
              _users,
              currentUserInterests,
              sharedInterestsMap,
              widget.genderType,
            );
            _users = result['users'];
            sharedInterestsMap = result['sharedInterestsMap'];
          }

          if (snapshot.hasData && _users.isNotEmpty) {
            return GridView.builder(
                itemCount: _users.length, // ! Using all users from db
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  mainAxisExtent: 250, // ! height of grid items
                  crossAxisSpacing: 20,
                ),
                itemBuilder: (context, i) {
                  return ProfileSquare(
                    image: _userImage,
                    name: _users[i]['name'],
                    sharedInterests: sharedInterestsMap.values.toList()[i],
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return ViewProfile(
                          id: _users[i]['uid'],
                          name: _users[i]['name'],
                          age: _users[i]['age'],
                          city: _users[i]['city'],
                          country: _users[i]['country'],
                          bio: _users[i]['bio'],
                          interests: _users[i]['interests'],
                          sharedInterests:
                              sharedInterestsMap.values.toList()[i],
                          userImage: _userImage,
                        );
                      }));

                      printStuff(); // ! til debug
                    },
                  );
                });
          }
          return Container();
        });
  }
}
