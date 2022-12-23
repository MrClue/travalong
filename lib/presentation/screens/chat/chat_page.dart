import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:travalong/presentation/resources/colors.dart';
import 'package:travalong/presentation/resources/widgets/atoms/back_arrow.dart';
import 'package:travalong/presentation/resources/widgets/atoms/safe_scaffold.dart';
import 'package:travalong/presentation/resources/widgets/molecules/theme_topbar.dart';
import 'package:travalong/presentation/screens/chat/widgets/chatwidgets.dart';
import 'package:intl/intl.dart';

class ChatPage extends StatefulWidget {
  final String id;
  final String name;
  const ChatPage({Key? key, required this.id, required this.name})
      : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final firestore = FirebaseFirestore.instance;
  var chatId;
  var name;

  @override
  Widget build(BuildContext context) {
    return SafeScaffoldNoNavbar(
      topbar: ThemeTopBar(
        title: widget.name,
        enableCustomButton: false,
        backArrow: const BackArrow(),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
            ),
          ),
          Expanded(
            child: Container(
              decoration: Styles.chatsBox(),
              // ! Streambuilder to access chats collection and snap chat doc
              child: StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection('chats').snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.docs.isNotEmpty) {
                      List<QueryDocumentSnapshot<Object?>> alldata = snapshot
                          .data!.docs
                          .where((element) =>
                              element['users'].contains(widget.id) &&
                              element['users'].contains(
                                  FirebaseAuth.instance.currentUser!.uid))
                          .toList();
                      QueryDocumentSnapshot? data =
                          alldata.isNotEmpty ? alldata.first : null;
                      if (data != null) {
                        chatId = data.id;
                      }
                      return data == null
                          ? Container()
                          : StreamBuilder(
                              // ! Second Streambuilder to access messenges collection
                              stream: data.reference
                                  .collection('messages')
                                  .orderBy('datetime', descending: true)
                                  .snapshots(),
                              builder:
                                  (context, AsyncSnapshot<QuerySnapshot> snap) {
                                return !snap.hasData
                                    ? Container()
                                    : ListView.builder(
                                        itemCount: snap.data!.docs.length,
                                        reverse: true,
                                        itemBuilder: (context, i) {
                                          return ChatWidgets.messagesCard(
                                              snap.data!.docs[i]['sent_by'] !=
                                                  widget.id,
                                              snap.data!.docs[i]['message'],
                                              DateFormat('hh:mm a').format(snap
                                                  .data!.docs[i]['datetime']
                                                  .toDate()));
                                        },
                                      );
                              });
                    } else {
                      const Center(
                        child: Text('No chats found'),
                      );
                    }
                  } else {
                    const Center(
                      child: CircularProgressIndicator(color: Colors.indigo),
                    );
                  }
                  return Container();
                },
              ),
            ),
          ),
          Container(
            color: TravalongColors.primary_30_stroke,
            child: ChatWidgets.messageField(onSubmit: (controller) {
              if (controller.text.toString() != '') {
                if (chatId != null) {
                  Map<String, dynamic> data = {
                    'message': controller.text.trim(),
                    'sent_by': FirebaseAuth.instance.currentUser!.uid,
                    'datetime': DateTime.now(),
                  };
                  FirebaseFirestore.instance
                      .collection('chats')
                      .doc(chatId)
                      .update({
                    'last_message_time': DateTime.now(),
                    'last_message': controller.text,
                  });
                  FirebaseFirestore.instance
                      .collection('chats')
                      .doc(chatId)
                      .collection('messages')
                      .add(data);
                } else {
                  Map<String, dynamic> data = {
                    'message': controller.text.trim(),
                    'sent_by': FirebaseAuth.instance.currentUser!.uid,
                    'datetime': DateTime.now(),
                  };
                  FirebaseFirestore.instance.collection('chats').add({
                    'users': [
                      widget.id,
                      FirebaseAuth.instance.currentUser!.uid
                    ],
                    'last_message': controller.text,
                    'last_message_time': DateTime.now(),
                  }).then((value) async {
                    value.collection('messages').add(data);
                  });
                }
              }
              controller.clear();
            }),
          )
        ],
      ),
    );
  }
}
