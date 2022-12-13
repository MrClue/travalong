import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travalong/data/model/user.dart';

class DatabaseService {
  final String? uid;

  DatabaseService({this.uid});

  // reference for our collections
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");
  final CollectionReference chatCollection =
      FirebaseFirestore.instance.collection("chats");

  // saving the userdata
  Future savingUserData(AppUser user) async {
    final json = user.toJson();
    return await userCollection.doc(uid).set(json);
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
