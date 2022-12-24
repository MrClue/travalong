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

  int users = 0; // amount of users
  final String _userImage =
      "https://image-cdn.essentiallysports.com/wp-content/uploads/ishowspeed-740x600.jpg";

  // todo: vi skal query users i firebase baseret på deres ønskede "rejse dato", "gender" og fælles "interests/travel goals"
  List _users = []; // ! get from firebase
  void initUsersList() {
    // loop firestore og find alle users
    // derefter tilføjes de til _users listen
  }

  void printStuff() {
    debugPrint("date: ${widget.startDate} - ${widget.endDate}");
    debugPrint("gender: ${widget.genderType}");
    debugPrint("gender: ${widget.searchType}");
  }

  @override
  void initState() {
    super.initState();
    getUsers();
    printStuff(); // ! test
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
          debug: printStuff,
        );
      },
    );
  }
}
