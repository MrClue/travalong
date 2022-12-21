import 'package:flutter/material.dart';
import 'package:travalong/presentation/screens/chat/animated_dialog.dart';

class ChatWidgets {
  static Widget card({title, time, subtitle, onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Card(
        elevation: 0,
        child: ListTile(
          onTap: onTap,
          contentPadding: const EdgeInsets.all(5),
          leading: const Padding(
            padding: EdgeInsets.all(0.0),
            child: CircleAvatar(
                backgroundColor: Colors.grey,
                child: Icon(
                  Icons.person,
                  size: 30,
                  color: Colors.white,
                )),
          ),
          title: Text(title),
          subtitle: subtitle != null ? Text(subtitle) : null,
          trailing: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Text(time),
          ),
        ),
      ),
    );
  }

  static Widget circleProfile({onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            CircleAvatar(
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
                    child: Text(
                  'John',
                  style:
                      TextStyle(height: 1.5, fontSize: 12, color: Colors.black),
                  overflow: TextOverflow.ellipsis,
                )))
          ],
        ),
      ),
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
            const CircleAvatar(
              child: Icon(
                Icons.person,
                size: 13,
                color: Colors.white,
              ),
              backgroundColor: Colors.grey,
              radius: 10,
            ),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 250),
            child: Container(
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.all(10),
              child: Text(
                '$message\n\n$time',
                style: TextStyle(color: check ? Colors.white : Colors.black),
              ),
              decoration: Styles.messagesCardStyle(check),
            ),
          ),
          if (check)
            const CircleAvatar(
              child: Icon(
                Icons.person,
                size: 13,
                color: Colors.white,
              ),
              backgroundColor: Colors.grey,
              radius: 10,
            ),
          if (!check) const Spacer(),
        ],
      ),
    );
  }

  static messageField({required onSubmit}) {
    final con = TextEditingController();
    return Container(
      margin: const EdgeInsets.all(5),
      child: TextField(
        controller: con,
        decoration: Styles.messageTextFieldStyle(onSubmit: () {
          onSubmit(con);
        }),
      ),
      decoration: Styles.messageFieldCardStyle(),
    );
  }

  static searchBar(
    bool open,
  ) {
    return AnimatedDialog(
      height: open ? 800 : 0,
      width: open ? 400 : 0,
    );
  }

  static searchField({onSubmit}) {
    final con = TextEditingController();
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: Styles.messageFieldCardStyle(),
      child: TextField(
        controller: con,
        decoration: Styles.searchTextFieldStyle(onSubmit),
      ),
    );
  }
}

class Styles {
  static TextStyle h1() {
    return const TextStyle(
        fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white);
  }

  static friendsBox() {
    return const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15), topRight: Radius.circular(15)));
  }

  static messagesCardStyle(check) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: check ? Colors.indigo.shade300 : Colors.grey.shade300,
    );
  }

  static messageFieldCardStyle() {
    return BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.indigo),
        borderRadius: BorderRadius.circular(10));
  }

  static messageTextFieldStyle({required Function() onSubmit}) {
    return InputDecoration(
      border: InputBorder.none,
      hintText: 'Enter Message',
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      suffixIcon: IconButton(onPressed: onSubmit, icon: const Icon(Icons.send)),
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

  static searchBar(bool open) {
    return AnimatedDialog(
      height: open ? 800 : 0,
      width: open ? 400 : 0,
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
