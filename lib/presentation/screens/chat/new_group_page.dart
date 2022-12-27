import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travalong/presentation/resources/colors.dart';
import 'package:travalong/presentation/resources/widgets/atoms/back_arrow.dart';
import 'package:travalong/presentation/resources/widgets/atoms/safe_scaffold.dart';
import 'package:travalong/presentation/resources/widgets/molecules/search_bar.dart';
import 'package:travalong/presentation/resources/widgets/molecules/theme_topbar.dart';

class NewGroupChat extends StatefulWidget {
  const NewGroupChat({super.key});

  @override
  State<NewGroupChat> createState() => NewGroupChatState();
}

class NewGroupChatState extends State<NewGroupChat> {
  final TextEditingController searchController = TextEditingController();
  final TextEditingController groupNameController = TextEditingController();
  final firestore = FirebaseFirestore.instance;
  String search = "";
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
                    search = value.toLowerCase();
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
