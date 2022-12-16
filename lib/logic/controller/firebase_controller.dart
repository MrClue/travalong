import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

//DatabaseService database = DatabaseService();
//var db = DatabaseService().userCollection;

final docRef =
    FirebaseController().usersCollection.doc(FirebaseController().userID);

class FirebaseController {
  var userID = FirebaseAuth.instance.currentUser!.uid;
  var usersCollection = FirebaseFirestore.instance.collection('users');
  var userDataMap = <String, dynamic>{};

  // * Get document data-field based on field (JSON key)
  Future<String> getDocFieldData(String field) async {
    // [START getDocFieldData]
    try {
      await docRef.get().then(
        (DocumentSnapshot doc) {
          final data = doc.data() as Map<String, dynamic>;
          // userDataMap!.addEntries({field: data[field]}.entries); // ! shows warning
          userDataMap.addEntries({field: data[field]}.entries);
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

  // * Set document data-field value (JSON value) based on field (JSON key)
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
