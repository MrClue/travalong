import 'dart:math';

import 'package:flutter/material.dart';
import 'package:travalong/presentation/resources/colors.dart';
import 'package:travalong/presentation/resources/widgets/buttons/send_button.dart';
import 'package:travalong/presentation/resources/widgets/theme/theme_text.dart';

import '../../profile/profile_page.dart';

class ChatWidgets {
  bool timeEnabled = false;

  static Widget circleProfile({onTap, name}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: Colors.grey,
              backgroundImage: NetworkImage(MediaWidget.sampleImages[
                  Random().nextInt(MediaWidget.sampleImages.length)]),
            ),
            SizedBox(
              width: 50,
              child: Center(
                child: ThemeText(
                  textString: name,
                  height: 1.5,
                  fontSize: 12,
                  textColor: TravalongColors.primary_text_bright,
                  overflow: TextOverflow.clip,
                  fontWeight: FontWeight.normal,
                  maxLines: 1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget loading() {
    return const Center(
        child: CircularProgressIndicator(
      color: TravalongColors.secondary_10,
    ));
  }

  // * Chat cards
  static Widget card({title, time, subtitle, onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Card(
        elevation: 0,
        child: ListTile(
          onTap: onTap,
          contentPadding: const EdgeInsets.all(5),
          leading: Padding(
            padding: const EdgeInsets.all(0.0),
            child: CircleAvatar(
              radius: 40,
              backgroundColor: Colors.grey,
              backgroundImage: NetworkImage(MediaWidget.sampleImages[
                  Random().nextInt(MediaWidget.sampleImages.length)]),
            ),
          ),
          title: Text(
            title,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          subtitle: subtitle != null
              ? Text(
                  subtitle,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                )
              : null,
          trailing: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Text(time),
          ),
        ),
      ),
    );
  }

  static Widget chatDivider() {
    return const Divider(
      color: TravalongColors.primary_30_stroke,
      indent: 10,
      endIndent: 10,
      thickness: 2,
    );
  }

  static Widget messagesCard(bool check, message, time) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (check) const Spacer(),
          if (!check)
            CircleAvatar(
              backgroundColor: Colors.grey,
              radius: 16,
              backgroundImage: NetworkImage(MediaWidget.sampleImages[2]),
            ),
          Column(
            crossAxisAlignment:
                check ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 250),
                child: Container(
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.all(10),
                  decoration: Styles.messagesCardStyle(check),
                  child: Text(
                    '$message',
                    style: TextStyle(
                        color: check
                            ? TravalongColors.primary_text_dark
                            : TravalongColors.primary_text_bright),
                  ),
                ),
              ),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 250),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  alignment:
                      check ? Alignment.bottomRight : Alignment.bottomLeft,
                  child: Text(
                    '$time',
                    style: const TextStyle(
                        color: TravalongColors.primary_text_bright,
                        fontSize: 9),
                  ),
                ),
              ),
            ],
          ),
          if (check)
            CircleAvatar(
              backgroundColor: Colors.grey,
              radius: 16,
              backgroundImage: NetworkImage(MediaWidget.sampleImages.first),
            ),
          if (!check) const Spacer(),
        ],
      ),
    );
  }

  static messageField({required onSubmit}) {
    var con = TextEditingController();
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: TravalongColors.neutral_60,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: TravalongColors.primary_30_stroke,
          width: 2,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: TextField(
                controller: con,
                decoration: Styles.messageTextFieldStyle(onSubmit: () {
                  onSubmit(con);
                }),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12, left: 12),
            child: SendButton(
              color: TravalongColors.secondary_10,
              icon: Icons.send_rounded,
              onPressed: () {
                onSubmit(con);
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ! STYLES
class Styles {
  static TextStyle h1() {
    return const TextStyle(
        fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white);
  }

  static chatsBox() {
    return const BoxDecoration(
      color: TravalongColors.neutral_60,
    );
  }

  static messagesCardStyle(check) {
    return BoxDecoration(
      borderRadius: check
          ? const BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
              bottomLeft: Radius.circular(15))
          : const BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
              bottomRight: Radius.circular(15)),
      color: check
          ? TravalongColors.secondary_10
          : TravalongColors.primary_30_stroke,
    );
  }

  static messageFieldCardStyle() {
    return BoxDecoration(
        color: TravalongColors.neutral_60,
        border: Border.all(color: TravalongColors.secondary_10),
        borderRadius: BorderRadius.circular(15));
  }

  static messageTextFieldStyle({required Function() onSubmit}) {
    return const InputDecoration(
      border: InputBorder.none,
      focusColor: TravalongColors.secondary_10,
      hintText: 'Type a message...',
      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
    );
  }

  static searchTextFieldStyle(Function onSubmit) {
    return InputDecoration(
      border: InputBorder.none,
      hintText: 'Enter Name',
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      suffixIcon:
          IconButton(onPressed: () {}, icon: const Icon(Icons.search_rounded)),
    );
  }

  static searchField({Function(String)? onChange}) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: Styles.messageFieldCardStyle(),
      child: TextField(
        onChanged: onChange,
        decoration: Styles.searchTextFieldStyle(onChange!),
      ),
    );
  }
}
