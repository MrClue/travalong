import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:travalong/presentation/resources/widgets/atoms/safe_scaffold.dart';
import 'package:travalong/presentation/resources/widgets/molecules/search_bar.dart';
import 'package:travalong/presentation/screens/chat/chat_home_screen.dart';
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
  String search = "";
  bool check = true;

  @override
  void dispose() {
    textEditController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeScaffoldNoNavbar(
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
                    height: 50,
                    hintText: 'Search user',
                    text: 'Search',
                    onChanged: (value) {
                      if (!mounted) return;
                      setState(() {
                        search = value.toLowerCase();
                      });
                    },
                  ),
                ),
                Expanded(
                  child: StreamBuilder(
                    //! StreamBuilder
                    stream: firestore.collection('users').snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      List data = !snapshot.hasData
                          ? []
                          : snapshot.data!.docs
                              .where((element) =>
                                  element['name']
                                      .toString()
                                      .toLowerCase()
                                      .startsWith(search)
                                      .toString()
                                      .endsWith("$search\uf8ff") ||
                                  element['name']
                                      .toString()
                                      .toLowerCase()
                                      .contains(search))
                              .toList();
                      return ListView.builder(
                        itemCount: data.length,
                        itemBuilder: ((context, index) {
                          // Timestamp time =
                          return Column(
                            children: [
                              ChatWidgets.card(
                                  title: data[index]['name'],
                                  // time: DateFormat('EEE hh:mm')
                                  //     .format(time.toDate()),
                                  time: '',
                                  onTap: () {}),
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
