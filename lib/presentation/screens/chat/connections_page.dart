import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:travalong/logic/controller/firebase_controller.dart';
import 'package:travalong/presentation/resources/colors.dart';
import 'package:travalong/presentation/resources/widgets/atoms/back_arrow.dart';
import 'package:travalong/presentation/resources/widgets/atoms/safe_scaffold.dart';
import 'package:travalong/presentation/screens/chat/chat_page.dart';
import 'package:travalong/presentation/screens/chat/widgets/chatwidgets.dart';
import 'package:travalong/presentation/resources/widgets/molecules/theme_topbar.dart';

class ConnectionsPage extends StatefulWidget {
  const ConnectionsPage({super.key});

  @override
  State<StatefulWidget> createState() => _ConnectionsPageState();
}

final firestore = FirebaseFirestore.instance;
final fController = FirebaseController();

class _ConnectionsPageState extends State<ConnectionsPage> {
  TextEditingController _textEditController = TextEditingController();
  String _search = '';

  @override
  void dispose() {
    _textEditController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeScaffold(
      topbar: ThemeTopBar(
        title: "Connections",
        backArrow: const BackArrow(),
        enableCustomButton: false,
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
        color: TravalongColors.primary_text_dark,
        child: SizedBox(
          height: MediaQuery.of(context).size.height - 100,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _textEditController,
                    autofocus: false,
                    decoration: InputDecoration(
                      labelText: 'Search users',
                      hintText: "Type in username",
                      prefixIcon: const Icon(
                        Icons.search,
                        color: TravalongColors.secondary_10,
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(
                            color: TravalongColors.primary_30_stroke, width: 2),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(
                            color: TravalongColors.primary_30_stroke,
                            width: 1.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        gapPadding: 0.0,
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(
                            color: TravalongColors.secondary_10, width: 1.5),
                      ),
                    ),
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
                      var userDocument = (snapshot.data as QuerySnapshot)
                          .docs
                          .firstWhere((d) => d.id == fController.userID);

                      // Create a List connectionList
                      List<String> connectionList = List<String>.from(
                          userDocument.get('connectionsList') as List<dynamic>);

                      // Create a list of user data that includes only the documents with uid values that are present in the connectionList
                      List userData = snapshot.data!.docs
                          .where((doc) => connectionList.contains(doc.id))
                          .map((doc) => doc.data())
                          .toList();

                      // List data builds the search results
                      List data = !snapshot.hasData
                          ? []
                          : userData
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
                                },
                              ),
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
