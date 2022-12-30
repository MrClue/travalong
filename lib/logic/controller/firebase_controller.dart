import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/foundation.dart';

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
    try {
      await docRef.get().then(
        (DocumentSnapshot doc) {
          final data = doc.data() as Map<String, dynamic>;
          // userDataMap!.addEntries({field: data[field]}.entries); // ! shows warning
          userDataMap.addEntries({field: data[field]}.entries);
        },
        onError: (e) => debugPrint("Error getting document: $e"),
      );
      //debugPrint(userDataMap[field]);
      return userDataMap[field].toString();
    } catch (e) {
      return 'Error';
    }
  }

  // * Set document data-field value (JSON value) based on field (JSON key)
  Future setDocFieldData(String field, dynamic value) async {
    //debugPrint("setDocfieldData - docRef: " + docRef.toString());
    final data = {field: value};
    try {
      await docRef.set(data, SetOptions(merge: true));
    } catch (e) {
      debugPrint("Error seting values into field: $e");
    }
  }

  getUsers() {
    return usersCollection.get();
  }
}
