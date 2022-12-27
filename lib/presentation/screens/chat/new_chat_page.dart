import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:travalong/presentation/resources/widgets/atoms/safe_scaffold.dart';
import 'package:travalong/presentation/resources/widgets/molecules/search_bar.dart';
import 'package:travalong/presentation/screens/chat/chat_home_screen.dart';
import 'package:travalong/presentation/screens/chat/chat_page.dart';
import 'package:travalong/presentation/screens/chat/widgets/chatwidgets.dart';
import 'package:travalong/presentation/resources/widgets/molecules/theme_topbar.dart';
import 'package:travalong/presentation/resources/widgets/atoms/back_arrow.dart';
import 'package:intl/intl.dart';
import '../../resources/colors.dart';
import '../../resources/widgets/molecules/icon_title_btn_widget.dart';
import 'new_group_page.dart';

class NewChatWidget extends StatefulWidget {
  NewChatWidget({super.key});

  @override
  State<NewChatWidget> createState() => _NewChatWidgetState();
}

class _NewChatWidgetState extends State<NewChatWidget> {
  final TextEditingController textEditController = TextEditingController();
  final firestore = FirebaseFirestore.instance;
  String _search = "";
  bool check = true;

  @override
  void dispose() {
    textEditController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeScaffold(
      topbar: ThemeTopBar(
        title: "New Chat",
        backArrow: const CancelArrow(),
        enableCustomButton: false,
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
        color: TravalongColors.neutral_60,
        child: SizedBox(
          height: 500,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                IconTitleButton(
                  faIcon: Icons.people_outlined,
                  label: "Start a group chat",
                  goToPage: NewGroupChat(),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
                  child: SearchBar.searchBar(
                    controller: textEditController,
                    height: 50.0,
                    hintText: 'Search user',
                    text: 'Search',
                    onChanged: (value) {
                      if (!mounted) return;
                      setState(() {
                        _search = value.toLowerCase();
                      });
                    },
                  ),
                ),
                Expanded(
                  child: StreamBuilder(
                    //! StreamBuilder
                    stream: firestore.collection('users').snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
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


                      // List data builds the search results
                      List data = !snapshot.hasData
                          ? []
                          : snapshot.data!.docs
                              .where((doc) => doc.id != fController.userID)
                              .where((element) =>
                                  element['name']
                                      .toString()
                                      .toLowerCase()
                                      .startsWith(_search)
                                      .toString()
                                      .endsWith("$_search\uf8ff") ||
                                  element['name']
                                      .toString()
                                      .toLowerCase()
                                      .contains(_search))
                              .toList();
                      return ListView.builder(
                        itemCount: data.length,
                        itemBuilder: ((context, i) {
                          // Timestamp time =
                          return Column(
                            children: [
                              ChatWidgets.card(
                                  title: data[i]['name'],
                                  // time: DateFormat('EEE hh:mm')
                                  //     .format(time.toDate()),
                                  time: '',
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) {
                                      return ChatPage(
                                          id: userData[i]['uid'],
                                          name: userData[i]['name']);
                                    }));
                                  }),
                              ChatWidgets.chatDivider(),
                            ],
                          );
                        }),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
