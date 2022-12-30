import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travalong/logic/controller/firebase_controller.dart';

class ConnectionsController {
  final String? uid;
  ConnectionsController({this.uid});

  FirebaseController fController = FirebaseController();

  void setOtherUserConnections(widgetId) {
    fController.usersCollection.doc(widgetId).set({
      'connectionsList':
          FieldValue.arrayUnion([FirebaseAuth.instance.currentUser!.uid]),
    }, SetOptions(merge: true)).then(
        (value) => debugPrint("Other new user connections successfully set!"),
        onError: (e) => debugPrint("Error if else $e"));
  }

  void updateOtherUserConnections(widgetId) {
    fController.usersCollection.doc(widgetId).update({
      'connectionsList':
          FieldValue.arrayUnion([FirebaseAuth.instance.currentUser!.uid]),
    }).then(
        (value) => debugPrint("Other user connections successfully updated!"),
        onError: (e) => debugPrint("Error updating other user connections $e"));
  }

  void setUserConnections(widgetId) {
    fController.usersCollection
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({
      'connectionsList': FieldValue.arrayUnion([widgetId]),
    }, SetOptions(merge: true)).then(
            (value) => debugPrint("New user connections successfully set!"),
            onError: (e) => debugPrint("Error if else $e"));
  }

  void updateUserConnections(widgetId) {
    fController.usersCollection
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      'connectionsList': FieldValue.arrayUnion([widgetId]),
    }).then((value) => debugPrint("User connections successfully updated!"),
            onError: (e) => debugPrint("Error updating user connections $e"));
  }
}
