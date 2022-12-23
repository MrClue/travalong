import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:travalong/data/model/user.dart';

class ChatService {
  final String? uid;
  ChatService({this.uid});

  void updateAvailability() {
    final firestore = FirebaseFirestore.instance;
    final auth = FirebaseAuth.instance;
    final data = {
      'name': auth.currentUser!.displayName ?? auth.currentUser!.email,
      'date_time': DateTime.now(),
      'email': auth.currentUser!.email,
    };
    try {
      firestore.collection('users').doc(auth.currentUser!.uid).set(data);
    } catch (e) {
      print(e);
    }
  }

  // add a chatroom into firebase
  Future<void> addChatRoom(chatRoom, chatRoomId) async {
    FirebaseFirestore.instance
        .collection('chatRooms')
        .doc(chatRoomId)
        .set(chatRoom)
        .catchError((e) {
      print(e);
    });
  }

  // get chat ordered by time
  getChats(String chatRoomId) async {
    return FirebaseFirestore.instance
        .collection("chatRooms")
        .doc(chatRoomId)
        .collection("chats")
        .orderBy('time')
        .snapshots();
  }

  // add message in a chatroom into firebase
  Future<void> addMessage(String chatRoomId, chatMessageData) async {
    FirebaseFirestore.instance
        .collection("chatRooms")
        .doc(chatRoomId)
        .collection("chats")
        .add(chatMessageData)
        .catchError((e) {
      print(e.toString());
    });
  }

  // get user chats from firebase
  getUserChats(String currentUid) async {
    return await FirebaseFirestore.instance
        .collection("chatRooms")
        .where('users', arrayContains: currentUid)
        .snapshots();
  }
}
