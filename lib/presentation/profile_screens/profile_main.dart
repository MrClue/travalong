import 'package:flutter/material.dart';
import 'user.dart';

class MyProfile extends StatelessWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Main Profile Page",
      home: Profile(),
    );
  }
}

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = UserPreferences.myUser;

    return Scaffold(

      body: SafeArea(
        child: Column(
          children: [

            Container(
              color: Colors.red,
              width: double.infinity,
              height: 215,

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ProfileWidget(
                        imagePath: user.imagePath
                      ),
                      Text("NAME")
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text("Connections"),
                      Text("Shared Media"),
                      Text("Goals Acheived")
                    ],
                  )
                ],
              ),
            )



          ],
        ),
      ),
    );
  }
}

class ProfileWidget extends StatelessWidget {
  final String imagePath;

  const ProfileWidget({
    Key? key,
    required this.imagePath
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}




