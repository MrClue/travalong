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
  var userDataMap = <String, dynamic>{};

  TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

DatabaseService database = DatabaseService();
var db = DatabaseService().userCollection;
var userid = FirebaseAuth.instance.currentUser!.uid;
final colRef = FirebaseFirestore.instance.collection('users');

class _TestPageState extends State<TestPage> {
  TestPage userdata = TestPage();
  final docRef = FirebaseFirestore.instance.collection('users').doc(userid);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeScaffoldNoNavbar(
        topbar: const TopBar(
          title: 'Search',
        ),
        child: Column(
          children: [
            FutureBuilder(
              future: getDocFieldData('name'),
              builder: (context, snapshot) {
                setDocFieldData('gender', 'male');
                return Center(
                  child: Text(snapshot.data.toString()),
                );
              },
            ),
            FutureBuilder(
              future: getDocFieldData('age'),
              builder: (context, snapshot) {
                return Center(
                  child: Text(snapshot.data.toString()),
                );
              },
            ),
            FutureBuilder(
              future: getDocFieldData('city'),
              builder: (context, snapshot) {
                return Center(
                  child: Text(snapshot.data.toString()),
                );
              },
            ),
          ],
        ));
  }

  // Get document datafield based on field
  Future<String> getDocFieldData(String field) async {
    // [START getDocFieldData]
    await docRef.get().then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        userdata.userDataMap!.addEntries({field: data[field]}.entries);
        print(userdata.userDataMap);
      },
      onError: (e) => print("Error getting document: $e"),
    );
    return userdata.userDataMap[field].toString();
    // [END getDocFieldData]
  }

// Get document datafield based on field
  Future setDocFieldData(String field, dynamic value) async {
    // [START setDocFieldData]
    final data = {field: value};
    try {
      await docRef.set(data, SetOptions(merge: true));
    } catch (e) {
      print("Error seting values into field: $e");
    }
    // [END setDocFieldData]
  }
}
