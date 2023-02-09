import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travalong/logic/controller/firebase_controller.dart';
import 'package:travalong/presentation/resources/colors.dart';
import 'package:travalong/presentation/resources/widgets/theme/back_arrow.dart';
import 'package:travalong/presentation/resources/widgets/theme/safe_scaffold.dart';
import 'package:travalong/presentation/resources/widgets/navigation/search_bar.dart';
import 'package:travalong/presentation/resources/widgets/navigation/theme_topbar.dart';
import 'package:travalong/presentation/screens/chat/widgets/chatwidgets.dart';

class NewGroupChat extends StatefulWidget {
  const NewGroupChat({super.key});

  @override
  State<NewGroupChat> createState() => NewGroupChatState();
}

final fController = FirebaseController();

class NewGroupChatState extends State<NewGroupChat> {
  final TextEditingController searchController = TextEditingController();
  final TextEditingController groupNameController = TextEditingController();
  final firestore = FirebaseFirestore.instance;
  String _search = '';
  bool check = true;

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeScaffold(
      topbar: ThemeTopBar(
        title: 'New Group',
        backArrow: const BackArrow(),
        enableCustomButton: true,
        customButtonWidget: IconButton(
          onPressed: check ? () {} : () {}, // If check then onPressed is on
          icon: const Icon(Icons.add, size: 25),
          color: check
              ? TravalongColors.secondary_10
              : TravalongColors.secondary_text_dark,
        ),
      ),
      child: Container(
        color: TravalongColors.neutral_60,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: SizedBox(
                  height: 20,
                  width: MediaQuery.of(context).size.width,
                  child: TextField(
                    textAlign: TextAlign.start,
                    controller: groupNameController,
                    textAlignVertical: TextAlignVertical.top,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Group name (required)',
                      hintStyle: GoogleFonts.poppins(
                        color: TravalongColors.secondary_text_bright,
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(8.0),
                height: 60,
                width: MediaQuery.of(context).size.width,
                color: TravalongColors.primary_30,
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                ),
              ),
              SearchBar.searchBar(
                controller: searchController,
                height: 50,
                hintText: 'Search user',
                text: 'Search',
                onChanged: (value) {
                  if (!mounted) return;
                  setState(() {
                    _search = value.toLowerCase();
                  });
                },
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
                              onTap: () {},
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
    );
  }
}
