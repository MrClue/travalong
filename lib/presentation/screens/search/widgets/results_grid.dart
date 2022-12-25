import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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

  List _users = []; // list of users from firebase
  // TODO: _users skal være en liste af brugere der matcher søgekriterierne
  void initUsersList(AsyncSnapshot<QuerySnapshot> snapshot) {
    _users = !snapshot.hasData
        ? []
        : snapshot.data!.docs
            .where((element) =>
                element['uid'].toString().contains(fController.userID) ==
                    false &&
                element['gender']
                        .toString()
                        .contains(widget.genderType.toLowerCase()) ==
                    true)
            .toList();

    debugPrint("users: " + _users.length.toString());
    // remove users that dont match search criteria

    /*for (var i = 0; i < _users.length; i++) {
      // remove users that dont match gender criteria
      debugPrint(_users[i]['gender']);

      if (widget.genderType != "Any" &&
          _users[i]['gender'].toString() !=
              widget.genderType.toLowerCase().toString()) {
        _users.removeAt(i);
        debugPrint("removed user");
      }
    }*/
  }

  void printStuff() {
    debugPrint("date: ${widget.startDate} - ${widget.endDate}");
    debugPrint("gender: ${widget.genderType}");
    debugPrint("gender: ${widget.searchType}");
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
      },
    );
  }
}
