import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travalong/presentation/resources/colors.dart';
import 'package:travalong/presentation/resources/widgets/atoms/back_arrow.dart';
import 'package:travalong/presentation/resources/widgets/molecules/topbar.dart';

import '../../data/messages_data.dart';
import '../resources/widgets/atoms/send_button.dart';
import '../resources/widgets/molecules/avatar.dart';

class ChatScreen extends StatelessWidget {
  static Route route(MessageData data) => MaterialPageRoute(
        builder: (context) => ChatScreen(
          messageData: data,
        ),
      );

  const ChatScreen({
    Key? key,
    required this.messageData,
  }) : super(key: key);

  final MessageData messageData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBarChatName(
        title: _AppBarTitle(
          messageData: messageData,
        ),
        //title: "TODO Person",
        leading: BackArrow(),
      ),
      body: Column(
        children: const [
          Expanded(
            child: _DemoMessageList(),
          ),
          _ActionBar(),
        ],
      ),
    );
  }
}

class _DemoMessageList extends StatelessWidget {
  const _DemoMessageList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView(
        children: const [
          _DateLable(lable: '29/11/2022'),
          _MessageTile(
            message: 'Hi, Buddy? Where are you from?',
            messageDate: '12:01 PM',
          ),
          _MessageOwnTile(
            message: 'Im from Mexico amigo!',
            messageDate: '12:02 PM',
          ),
          _MessageTile(
            message: 'Any events on friday in Mexico City?',
            messageDate: '12:02 PM',
          ),
          _MessageOwnTile(
            message: 'Yeah, football at the Uni :D How many are you guys?',
            messageDate: '12:03 PM',
          ),
          _MessageTile(
            message: 'Me and my friend from Denmark!',
            messageDate: '12:05 PM',
          ),
          _MessageOwnTile(
            message: 'Nice, you are welcome to come by!',
            messageDate: '12:05 PM',
          ),
          _MessageOwnTile(
            message: 'Bring some boots, we play many people',
            messageDate: '12:06 PM',
          ),
          _MessageTile(
            message: 'All right, I think we have',
            messageDate: '12:09 PM',
          ),
          _MessageOwnTile(
            message: 'Nice, if theres anything, let me know',
            messageDate: '12:10 PM',
          ),
        ],
      ),
    );
  }
}

class _MessageTile extends StatelessWidget {
  const _MessageTile({
    Key? key,
    required this.message,
    required this.messageDate,
  }) : super(key: key);

  final String message;
  final String messageDate;

  static const _borderRadius = 20.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: const BoxDecoration(
                color: TravalongColors.primary_30_stroke,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(_borderRadius),
                  topRight: Radius.circular(_borderRadius),
                  bottomRight: Radius.circular(_borderRadius),
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20),
                child: Text(
                  message,
                  style: const TextStyle(
                    color: TravalongColors.primary_text_bright,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                messageDate,
                style: const TextStyle(
                  color: TravalongColors.primary_text_bright,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _MessageOwnTile extends StatelessWidget {
  const _MessageOwnTile({
    Key? key,
    required this.message,
    required this.messageDate,
  }) : super(key: key);

  final String message;
  final String messageDate;

  static const _borderRadius = 20.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Align(
        alignment: Alignment.centerRight,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              decoration: const BoxDecoration(
                color: TravalongColors.secondary_10,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(_borderRadius),
                  topRight: Radius.circular(_borderRadius),
                  bottomLeft: Radius.circular(_borderRadius),
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20),
                child: Text(message,
                    style: const TextStyle(
                      color: TravalongColors.primary_text_dark,
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                messageDate,
                style: const TextStyle(
                  color: TravalongColors.primary_text_bright,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _DateLable extends StatelessWidget {
  const _DateLable({
    Key? key,
    required this.lable,
  }) : super(key: key);

  final String lable;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12),
            child: Text(
              lable,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.normal,
                color: TravalongColors.primary_text_bright,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _AppBarTitle extends StatelessWidget {
  const _AppBarTitle({
    Key? key,
    required this.messageData,
  }) : super(key: key);

  final MessageData messageData;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Avatar.small(
          url: messageData.profilePicture,
        ),
        const SizedBox(
          width: 16,
        ),
        Text(
          messageData.senderName,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.normal,
              fontSize: 20,
              color: TravalongColors.primary_text_bright),
        ),
      ],
    );
  }
}

class _ActionBar extends StatelessWidget {
  const _ActionBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      top: false,
      child: Container(
        height: 60,
        width: double.infinity,
        color: TravalongColors.primary_30_stroke,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 40,
            width: MediaQuery.of(context).size.width - 10,
            decoration: BoxDecoration(
              color: TravalongColors.neutral_60,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: TravalongColors.primary_30_stroke,
                width: 2,
              ),
            ),
            child: Center(
              child: Row(
                children: [
                  const Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 20, bottom: 10),
                      child: TextField(
                        textAlignVertical: TextAlignVertical.center,
                        style: TextStyle(fontSize: 14),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusColor: TravalongColors.secondary_10,
                          hintText: 'Type a message...',
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 12,
                      right: 24.0,
                    ),
                    child: SendButton(
                      color: TravalongColors.secondary_10,
                      icon: Icons.send_rounded,
                      onPressed: () {
                        print('TODO: send a message');
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
