import 'package:flutter/material.dart';
import 'package:travalong/logic/controller/firebase_controller.dart';
import 'package:travalong/presentation/resources/widgets/atoms/safe_scaffold.dart';
import 'package:travalong/presentation/resources/widgets/molecules/topbar.dart';

class TestPage extends StatelessWidget {
  // * creates instance of firebase_controller class
  FirebaseController fController = FirebaseController();

  TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeScaffoldNoNavbar(
        topbar: const TopBar(
          title: 'Search',
        ),
        child: Column(
          children: [
            FutureBuilder(
              future: fController.getDocFieldData('name'),
              builder: (context, snapshot) {
                fController.setDocFieldData('gender', 'female');
                return Center(
                  child: Text(snapshot.data.toString()),
                );
              },
            ),
            FutureBuilder(
              future: fController.getDocFieldData('age'),
              builder: (context, snapshot) {
                return Center(
                  child: Text(snapshot.data.toString()),
                );
              },
            ),
            FutureBuilder(
              future: fController.getDocFieldData('city'),
              builder: (context, snapshot) {
                return Center(
                  child: Text(snapshot.data.toString()),
                );
              },
            ),
            FloatingActionButton(onPressed: () {
              print("current users ID: " + fController.userID); // * det virker
              print(
                  "collection type: " + fController.usersCollection.toString());
            })
          ],
        ));
  }
}
