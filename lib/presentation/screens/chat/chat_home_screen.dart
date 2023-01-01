import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:travalong/logic/controller/firebase_controller.dart';
import 'package:travalong/presentation/resources/colors.dart';
import 'package:travalong/presentation/resources/widgets/atoms/safe_scaffold.dart';
import 'package:travalong/presentation/resources/widgets/molecules/search_bar.dart';
import 'package:travalong/presentation/resources/widgets/molecules/theme_topbar.dart';
import 'package:travalong/presentation/screens/chat/chat_page.dart';
import 'package:travalong/presentation/screens/chat/widgets/chatwidgets.dart';
import 'package:travalong/presentation/screens/screens.dart';

class ChatHomeScreen extends StatefulWidget {
  const ChatHomeScreen({Key? key}) : super(key: key);

  @override
  State<ChatHomeScreen> createState() => _ChatHomeScreenState();
}

final firestore = FirebaseFirestore.instance;
final fController = FirebaseController();

class _ChatHomeScreenState extends State<ChatHomeScreen> {
  bool check = false;
  @override
  Widget build(BuildContext context) {
    return SafeScaffold(
      topbar: ThemeTopBar(
        enableCustomButton: true,
        customButtonWidget: IconButton(
          icon: const Icon(
            Icons.edit_outlined,
            color: TravalongColors.secondary_10,
          ),
          onPressed: (() {
            showModalBottomSheet(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
              ),
              context: context,
              builder: (BuildContext context) {
                return const NewChatWidget();
              },
            );
          }),
        ),
        title: 'Chats',
      ),
      child: SafeArea(
        child: Stack(
          alignment: AlignmentDirectional.topEnd,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.all(0),
                  child: Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: TravalongColors.primary_30_stroke,
                          width: 2,
                        ),
                      ),
                      color: TravalongColors.neutral_60,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: SearchBar.staticSearchBar(),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Connections',
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 16,
                                  color: TravalongColors.primary_text_bright,
                                ),
                              ),
                              SizedBox(
                                height: 25,
                                width: 65,
                                child: FloatingActionButton.extended(
                                  backgroundColor: TravalongColors.secondary_10,
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              const ConnectionsPage()),
                                    );
                                  },
                                  label: Text(
                                    "View all",
                                    style: GoogleFonts.poppins(
                                        color:
                                            TravalongColors.secondary_text_dark,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          height: 80,
                          child: StreamBuilder(
                              // ! START STREAMBUILDER
                              stream: firestore.collection('users').snapshots(),
                              builder: (context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (!snapshot.hasData) {
                                  return ChatWidgets.loading();
                                }

                                // create userDoc
                                var userDocument =
                                    (snapshot.data as QuerySnapshot)
                                        .docs
                                        .firstWhere(
                                            (d) => d.id == fController.userID);

                                // Create a List connectionList
                                List<String> connectionList = List<String>.from(
                                    userDocument.get('connectionsList')
                                        as List<dynamic>);

                                // Create a list of user data that includes only the documents with uid values that are present in the connectionList
                                List userData = snapshot.data!.docs
                                    .where((doc) =>
                                        connectionList.contains(doc.id))
                                    .map((doc) => doc.data())
                                    .toList();

                                return !snapshot.hasData
                                    ? ChatWidgets.loading()
                                    : ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: userData.length,
                                        itemBuilder: (context, i) {
                                          //! BUILD USER CIRCLEPROFILES
                                          return !snapshot.hasData
                                              ? ChatWidgets.loading()
                                              : ChatWidgets.circleProfile(
                                                  name: userData[i]['name'],
                                                  onTap: () {
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder: (context) {
                                                      return ChatPage(
                                                          id: userData[i]
                                                              ['uid'],
                                                          name: userData[i]
                                                              ['name']);
                                                    }));
                                                  },
                                                );
                                        },
                                      );
                              }),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: Styles.chatsBox(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: StreamBuilder(
                              //! START STREAMBUILDER
                              stream: firestore.collection('chats').snapshots(),
                              builder: (context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                List data = !snapshot.hasData
                                    ? []
                                    : snapshot.data!.docs
                                        .where((element) => element['users']
                                            .toString()
                                            .contains(FirebaseAuth
                                                .instance.currentUser!.uid))
                                        .toList();
                                return ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    itemCount: data.length,
                                    itemBuilder: (context, i) {
                                      List users = data[i]['users'];
                                      var friend = users.where((element) =>
                                          element !=
                                          FirebaseAuth
                                              .instance.currentUser!.uid);
                                      var user = friend.isNotEmpty
                                          ? friend.first
                                          : users
                                              .where((element) =>
                                                  element ==
                                                  FirebaseAuth.instance
                                                      .currentUser!.uid)
                                              .first;
                                      return StreamBuilder(
                                          //!User Collection
                                          stream: fController.usersCollection
                                              .doc(user)
                                              .snapshots(),
                                          builder:
                                              (context, AsyncSnapshot snap) {
                                            // ! BUILD USER CARDS
                                            return !snap.hasData
                                                ? ChatWidgets.loading()
                                                : Column(
                                                    children: [
                                                      ChatWidgets.card(
                                                        title:
                                                            snap.data['name'],
                                                        subtitle: data[i]
                                                            ['last_message'],
                                                        time: DateFormat(
                                                                'hh:mm a')
                                                            .format(data[i][
                                                                    'last_message_time']
                                                                .toDate()),
                                                        onTap: () {
                                                          Navigator.of(context)
                                                              .push(
                                                            MaterialPageRoute(
                                                              builder:
                                                                  (context) {
                                                                return ChatPage(
                                                                  id: user,
                                                                  name: snap
                                                                          .data[
                                                                      'name'],
                                                                );
                                                              },
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                      ChatWidgets.chatDivider(),
                                                    ],
                                                  );
                                          });
                                    });
                              }),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
