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
  Future saveUserData(AppUser user) async {
    final json = user.toJson();
    return await userCollection.doc(uid).set(json);
  }

  Future getData() async {
    QuerySnapshot<Object?> snapshot = await userCollection.get();
    return snapshot;
  }

  // getting user data
  Future getUserData(String uid) async {
    QuerySnapshot snapshot =
        await userCollection.where("uid", isEqualTo: uid).get();
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

  // getting amount of users
  Future<int> getCount() async {
    int count = await FirebaseFirestore.instance
        .collection('collection')
        .get()
        .then((value) => value.size);
    return count;
  }
}
