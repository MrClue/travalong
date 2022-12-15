import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travalong/logic/services/database_service.dart';
import 'package:travalong/presentation/resources/widgets/atoms/safe_scaffold.dart';
import 'package:travalong/presentation/resources/widgets/molecules/topbar.dart';

// * STEP 1: Hent current_user fra firebase (getter)
// * STEP 2: Få fat i current_users "age" (getter)
// * STEP 3: Update current_users "age" i DB (setter)
// * STEP 4: Få fat i den opdateret current_users "age" og print i Text() (getter)

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

DatabaseService database = DatabaseService();
var db = DatabaseService().userCollection;
var userid = FirebaseAuth.instance.currentUser!.uid;

class _TestPageState extends State<TestPage> {
  var userCollectionRef = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return SafeScaffoldNoNavbar(
      topbar: const TopBar(
        title: 'Search',
      ),
      child: getUserData(),
    );
  }

  StreamBuilder getUserData() {
    return StreamBuilder<QuerySnapshot>(
      stream: userCollectionRef.snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error = ${snapshot.error}');
        }
        if (snapshot.hasData) {
          final users = snapshot.data!.docs;
          List<Text> userWidgets = [];
          for (var user in users) {
            final username = user.get('name');
            final useremail = user.get('email');
            final userWidget = Text('$username $useremail');

            userWidgets.add(userWidget);
          }
          return Column(
            children: userWidgets,
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
