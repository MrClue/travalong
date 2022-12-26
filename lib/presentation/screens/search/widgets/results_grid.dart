import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:travalong/data/model/user.dart';
import 'package:travalong/logic/controller/firebase_controller.dart';
import 'package:travalong/logic/services/database_service.dart';
import 'package:travalong/presentation/screens/search/search_page.dart';

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
  List _users = [];

  final String _userImage =
      "https://image-cdn.essentiallysports.com/wp-content/uploads/ishowspeed-740x600.jpg";

  // TODO: _users skal være en liste af brugere der matcher søgekriterierne
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
    List<dynamic> usersCopy = List.from(_users);

    for (var i = 0; i < usersCopy.length; i++) {
      // remove users that dont match gender criteria
      if (widget.genderType.toLowerCase() != 'any' &&
          usersCopy[i]['gender'].toString() !=
              widget.genderType.toLowerCase()) {
        _users.remove(usersCopy[i]);
      }
    }

    // * sort _users by common interests
    /*
    String _currentUserInterests = ""; // ! interests of current user

    fController.getDocFieldData(UserData.interests).then((interests) {
      _currentUserInterests = interests;
      debugPrint("current users interests: " + _currentUserInterests);

      // then we sort _users by common interests
      _users.sort((user1, user2) {
        // Get the interests of user1 and user2
        List<dynamic> interests1 = user1['interests'];
        List<dynamic> interests2 = user2['interests'];

        // Calculate the number of shared interests
        int sharedInterests1 = 0;
        int sharedInterests2 = 0;
        for (String interest in interests1) {
          if (_currentUserInterests.contains(interest)) {
            sharedInterests1++;
          }
        }
        for (String interest in interests2) {
          if (_currentUserInterests.contains(interest)) {
            sharedInterests2++;
          }
        }

        // Compare the number of shared interests and return -1, 0, or 1
        if (sharedInterests1 > sharedInterests2) {
          return -1;
        } else if (sharedInterests1 < sharedInterests2) {
          return 1;
        } else {
          return 0;
        }
      });
    });
    */
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
                            interests: _users[i]['interests']);
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
