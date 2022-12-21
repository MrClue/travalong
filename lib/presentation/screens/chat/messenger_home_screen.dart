import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travalong/logic/controller/firebase_controller.dart';
import 'package:travalong/presentation/resources/colors.dart';
import 'package:travalong/presentation/resources/widgets/atoms/safe_scaffold.dart';
import 'package:travalong/presentation/resources/widgets/atoms/theme_text.dart';
import 'package:travalong/presentation/resources/widgets/molecules/chatwidgets.dart';
import 'package:travalong/presentation/resources/widgets/molecules/search_bar.dart';
import 'package:travalong/presentation/resources/widgets/molecules/theme_topbar.dart';
import 'package:travalong/presentation/resources/widgets/molecules/topbar.dart';
import 'package:travalong/presentation/screens/chat/chat_page.dart';
import 'package:travalong/presentation/screens/screens.dart';
import 'package:intl/intl.dart';

class Messenger_home_screen extends StatefulWidget {
  const Messenger_home_screen({Key? key}) : super(key: key);
  @override
  State<Messenger_home_screen> createState() => _Messenger_home_screenState();
}

final firestore = FirebaseFirestore.instance;
final currentUid = FirebaseAuth.instance.currentUser!.uid;
final fController = FirebaseController();

class _Messenger_home_screenState extends State<Messenger_home_screen> {
  @override
  Widget build(BuildContext context) {
    return SafeScaffoldNoNavbar(
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
                    color: TravalongColors.primary_30,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    height: 182,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                              EdgeInsets.only(top: 12.0, left: 12, right: 12),
                          child: SearchBar(
                            hintText: 'Search',
                            onTapped: (() {}),
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(left: 16, right: 16, top: 16),
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
                                height: 22,
                                width: 63,
                                child: FloatingActionButton.extended(
                                  backgroundColor: TravalongColors.secondary_10,
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              ConnectionPage()),
                                    );
                                  },
                                  label: Text(
                                    "View all",
                                    style: GoogleFonts.poppins(
                                        color:
                                            TravalongColors.secondary_text_dark,
                                        fontWeight: FontWeight.normal,
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
                              stream: fController.usersCollection.snapshots(),
                              builder: (context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                List<QueryDocumentSnapshot>? data =
                                    snapshot.data!.docs.toList();
                                return ListView.builder(
                                  itemCount: data.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, i) {
                                    return circleProfile(
                                      name: snapshot.data!.docs[i]['name'],
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
                    margin: const EdgeInsets.only(top: 10),
                    decoration: Styles.friendsBox(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                        ),
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: StreamBuilder(
                                stream: fController.usersCollection.snapshots(),
                                builder: (context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  List<QueryDocumentSnapshot>? data =
                                      snapshot.data!.docs.toList();
                                  if (snapshot.hasData) {
                                    return ListView.builder(
                                      itemCount: data.length,
                                      itemBuilder: (context, i) {
                                        if (snapshot.data!.docs.isNotEmpty) {
                                          return ChatWidgets.card(
                                            title: snapshot.data!.docs[i]
                                                ['name'],
                                            subtitle: 'Hi, How are you !',
                                            time: '04:40',
                                            onTap: () {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (context) {
                                                    return ChatPage(
                                                      id: '',
                                                      title: 'name',
                                                    );
                                                  },
                                                ),
                                              );
                                            },
                                          );
                                        } else {
                                          return const Center(
                                            child: CircularProgressIndicator(
                                                color: TravalongColors
                                                    .secondary_10),
                                          );
                                        }
                                      },
                                    );
                                  }
                                  return const Center(
                                    child: CircularProgressIndicator(
                                        color: TravalongColors.secondary_10),
                                  );
                                }),
                          ),
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

  static Widget circleProfile({onTap, String? name}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 25,
              backgroundColor: Colors.grey,
              child: Icon(
                Icons.person,
                size: 40,
                color: Colors.white,
              ),
            ),
            SizedBox(
              width: 50,
              child: Center(
                child: ThemeText(
                  textString: name!,
                  height: 1.5,
                  fontSize: 12,
                  textColor: TravalongColors.primary_text_bright,
                  overflow: TextOverflow.ellipsis,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
