import 'package:flutter/material.dart';
import 'package:travalong/data/model/user.dart';
import 'package:travalong/logic/controller/firebase_controller.dart';
import 'package:travalong/presentation/resources/widgets/atoms/safe_scaffold.dart';
import 'package:travalong/presentation/resources/widgets/molecules/topbar.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  // * creates instance of firebase_controller class
  FirebaseController fController = FirebaseController();

  @override
  Widget build(BuildContext context) {
    return SafeScaffoldNoNavbar(
        topbar: const TopBar(
          title: 'Search',
        ),
        child: Column(
          children: [
            FutureBuilder(
              future: fController.getDocFieldData(UserData.gender),
              builder: (context, snapshot) {
                //fController.setDocFieldData('gender', 'female');
                return Center(
                  child: Column(
                    children: [
                      Text(snapshot.data.toString()),
                      FloatingActionButton(onPressed: () {
                        print("current users ID: ${fController.userID}");
                        print(
                            "collection type: ${fController.usersCollection}");

                        // * By using "setState()" inside the FutureBuilder, we reload the widget tree,
                        // * allowing us to see the changes by "setDocFieldData()" in real-time
                        // The widget tree is reloaded because "setState()" notifies the framework, 
                        // that the state of the app has changed, and forces a reload to reflect these changes.
                        setState(() {
                          if (snapshot.data == 'female') {
                            fController.setDocFieldData(
                                UserData.gender, 'male');
                          } else {
                            fController.setDocFieldData(
                                UserData.gender, 'female');
                          }
                        });
                      }),
                    ],
                  ),
                );
              },
            ),
            FutureBuilder(
              future: fController.getDocFieldData(UserData.age),
              builder: (context, snapshot) {
                return Center(
                  child: Text(snapshot.data.toString()),
                );
              },
            ),
            FutureBuilder(
              future: fController.getDocFieldData(UserData.city),
              builder: (context, snapshot) {
                return Center(
                  child: Text(snapshot.data.toString()),
                );
              },
            ),
          ],
        ));
  }
}
