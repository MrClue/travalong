import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

final docRef =
    FirebaseController().usersCollection.doc(FirebaseController().userID);

class FirebaseController {
  var userID = FirebaseAuth.instance.currentUser!.uid;
  var usersCollection = FirebaseFirestore.instance.collection('users');
  var chatsCollection = FirebaseFirestore.instance.collection('chats');
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
      debugPrint("Error setting values into field: $e");
    }
  }

  // * From Database service
  // todo: check what is being used in code

  
  // get users collection
  Future getData() async {
    QuerySnapshot snapshot = await usersCollection.get();
    return snapshot;
  }

  // get users collection data
  Future getUserColData(String uid) async {
    QuerySnapshot snapshot =
        await usersCollection.where('uid', isEqualTo: uid).get();
    return snapshot;
  }

  // get user document data
  Stream getUserDocData(String uid) {
    return usersCollection.doc(uid).snapshots();
  }

  // getting amount of users
  Future<int> getCount() async {
    int count = await FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((value) => value.size);
    return count;
  }
  
}
