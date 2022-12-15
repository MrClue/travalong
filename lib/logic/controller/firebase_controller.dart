//DatabaseService database = DatabaseService();
//var db = DatabaseService().userCollection;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final docRef = FirebaseFirestore.instance
    .collection('users')
    .doc(FirebaseController().userid);

class FirebaseController {
  var userDataMap = <String, dynamic>{};
  var userid = FirebaseAuth.instance.currentUser!.uid;

  // Get document datafield based on field
  Future<String> getDocFieldData(String field) async {
    // [START getDocFieldData]
    try {
      await docRef.get().then(
        (DocumentSnapshot doc) {
          final data = doc.data() as Map<String, dynamic>;
          userDataMap!.addEntries({field: data[field]}.entries);
        },
        onError: (e) => print("Error getting document: $e"),
      );
      print(userDataMap[field]);
      return userDataMap[field].toString();
    } catch (e) {
      return 'Error';
    }
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
