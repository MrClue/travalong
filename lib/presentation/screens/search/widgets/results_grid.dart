import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:travalong/data/model/user.dart';
import 'package:travalong/logic/controller/firebase_controller.dart';
import 'package:travalong/logic/services/database_service.dart';

import 'package:travalong/presentation/screens/search/view_profile_page.dart';
import 'package:travalong/presentation/screens/search/widgets/profile_square.dart';

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
  DatabaseService db = DatabaseService();

  final String _userImage =
      "https://image-cdn.essentiallysports.com/wp-content/uploads/ishowspeed-740x600.jpg";

  // TODO: skal matche søgekriterierne
  List _users = [];
  List currentUserInterests = [];
  Map<dynamic, int> copyAnotherMap = {}; // ! test

  void initUsersList(AsyncSnapshot<QuerySnapshot> snapshot) {
    _users = !snapshot.hasData
        ? []
        : snapshot.data!.docs
            .where((element) =>
                element['uid'].toString().contains(fController.userID) == false)
            .toList();

    //debugPrint("users: " + _users.length.toString());
    //debugPrint("selected: " + widget.genderType.toString());

    // * remove users that dont match search criteria
    List<dynamic> usersCopy = List.from(_users); // copy _users to fix index bug

    for (var i = 0; i < usersCopy.length; i++) {
      // remove users that dont match gender criteria
      if (widget.genderType.toLowerCase() != 'any' &&
          usersCopy[i]['gender'].toString() !=
              widget.genderType.toLowerCase()) {
        _users.remove(usersCopy[i]);
      }
    }

    // * sort _users by common interests

    Map<dynamic, int> sharedInterestsMap =
        {}; // <uid, number of shared interests>

    List sortedUsers = [];

    for (var i = 0; i < _users.length; i++) {
      // make sure interests is a list
      if (_users[i]['interests'] == null) {
        _users[i]['interests'] = [];
      }

      List interests1 = _users[i]['interests'];
      debugPrint("User ${_users[i]['name']} interests: $interests1");

      // Calculate the number of shared interests
      int sharedInterests = 0;

      for (String interest in interests1) {
        if (currentUserInterests.contains(interest)) {
          sharedInterests++;
        }
      }
      debugPrint(_users[i]['name'] + " shared interests: $sharedInterests");

      sharedInterestsMap[_users[i] /*['uid']*/] = sharedInterests;
    }
    // * sort sharedInterestsMap by value (sharedInterests)
    sharedInterestsMap = Map.fromEntries(sharedInterestsMap.entries.toList()
      ..sort((e1, e2) => e2.value.compareTo(e1.value)));

    debugPrint("sharedInterestsMap: $sharedInterestsMap");

    // Convert the map to a list containing the keys (sorted users)
    sortedUsers = sharedInterestsMap.keys.toList();
    debugPrint("sortedUsers list: $sortedUsers");

    if (sortedUsers.isNotEmpty) {
      _users = sortedUsers; // * returns correct output
    }

    // ! test
    copyAnotherMap = Map.from(sharedInterestsMap);
  }

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
      // Extract the interests string between the square brackets
      String stringValue = interests.substring(1, interests.length - 1);
      //debugPrint("stringValue: $stringValue");
      setState(() {
        currentUserInterests = stringValue.split(', ');
        debugPrint("current users interests: $currentUserInterests");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: db.userCollection.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          initUsersList(snapshot);
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
                          sharedInterests: copyAnotherMap.values.toList()[i],
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
