import 'package:flutter/material.dart';
import 'package:travalong/logic/controller/firebase_controller.dart';
import 'package:travalong/logic/services/database_service.dart';

import 'package:travalong/presentation/screens/search/view_profile_page.dart';
import 'package:travalong/presentation/screens/search/widgets/profile_square.dart';

class ResultsGrid extends StatefulWidget {
  @override
  State<ResultsGrid> createState() => _ResultsGridState();
}

class _ResultsGridState extends State<ResultsGrid> {
  FirebaseController fController = FirebaseController();

  DatabaseService db = DatabaseService();

  //List _users = ["User 1", "User 2"]; // ! get from firebase
  int users = 0; // amount of users
  final String _userImage =
      "https://image-cdn.essentiallysports.com/wp-content/uploads/ishowspeed-740x600.jpg";

  // todo: vi skal query users i firebase baseret på deres ønskede "rejse dato", "gender" og fælles "interests/travel goals"
  // 1: 

  @override
  void initState() {
    super.initState();
    getUsers();
  }

  // ! get amount of users in firebase (int)
  void getUsers() {
    db.getCount().then((count) {
      setState(() {
        users = count;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: /*_users.length*/ users,
      /*gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),*/
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        mainAxisExtent: 250, // ! height of grid items
        crossAxisSpacing: 20,
      ),
      itemBuilder: (context, index) {
        return ProfileSquare(
          image: _userImage,
          name: /*_users[index]*/ "User ${index + 1}",
          goToPage: ViewProfile(),
        );
      },
    );
  }
}
