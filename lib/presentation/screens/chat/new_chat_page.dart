import 'package:flutter/material.dart';
import 'package:travalong/presentation/screens/chat/messages_screen.dart';
import 'package:travalong/presentation/resources/widgets/atoms/back_arrow.dart';

import '../../resources/colors.dart';
import '../../resources/widgets/molecules/icon_title_btn_widget.dart';
import '../../resources/widgets/molecules/topbar.dart';
import '../../resources/widgets/molecules/search_bar.dart';

class NewChatWidget extends StatelessWidget {
  const NewChatWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      color: TravalongColors.primary_text_dark,
      child: Scaffold(
        appBar: const TopBar(
          title: "New Chat",
          leading: CancelArrow(),
        ),
        body: SizedBox(
          height: 500,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const IconTitleButton(
                  faIcon: Icons.people_outlined,
                  label: "Start a group chat",
                  goToPage: MessagesScreen(),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SearchBar(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
