import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatController {
  final String? uid;
  ChatController({this.uid});

  Future createNewChat(controller, widgetId) async {
    Map<String, dynamic> data = {
      'message': controller.text.trim(),
      'sent_by': FirebaseAuth.instance.currentUser!.uid,
      'datetime': DateTime.now(),
    };
    await FirebaseFirestore.instance.collection('chats').add({
      'users': [widgetId, FirebaseAuth.instance.currentUser!.uid],
      'last_message': controller.text.trim(),
      'last_message_time': DateTime.now(),
    }).then((value) async {
      value.collection('messages').add(data);
    });
  }

  Future updateChat(controller, chatId) async {
    Map<String, dynamic> data = {
      'message': controller.text.trim(),
      'sent_by': FirebaseAuth.instance.currentUser!.uid,
      'datetime': DateTime.now(),
    };
    await FirebaseFirestore.instance.collection('chats').doc(chatId).update({
      'last_message_time': DateTime.now(),
      'last_message': controller.text,
    });
    await FirebaseFirestore.instance
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .add(data);
  }
}
