import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String? uid;

  DatabaseService({this.uid});

  // reference for our collections
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");
  final CollectionReference chatCollection =
      FirebaseFirestore.instance.collection("chats");

  // saving the userdata
  Future savingUserData(String name, String email) async {
    return await userCollection.doc(uid).set({
      "uid": uid,
      "name": name,
      "email": email,
      "age": "",
      "city": "",
      "connections": "",
      "shareMedia": "",
      "goalsCompleted": "",
      "media": {},
      "chats": {},
      "interest": {},
      "travelgoals": {},
    });
  }

  // getting user data
  Future gettingUserData(String email) async {
    QuerySnapshot snapshot =
        await userCollection.where("email", isEqualTo: email).get();
    return snapshot;
  }

  // getting the chats
  getChats(String groupId) async {
    return chatCollection
        .doc(groupId)
        .collection("messages")
        .orderBy("time")
        .snapshots();
  }
}
