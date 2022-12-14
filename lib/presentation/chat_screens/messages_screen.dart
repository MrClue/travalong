import 'package:faker/faker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jiffy/jiffy.dart';
import 'package:travalong/logic/services/database_service.dart';
import 'package:travalong/presentation/chat_screens/connection_page.dart';
import 'package:travalong/presentation/resources/colors.dart';

import '../../data/messages_data.dart';
import '../../data/model/user.dart';
import '../../data/story_data.dart';
import '../../logic/Helpers.dart';
import '../resources/widgets/molecules/avatar.dart';
import '../resources/widgets/molecules/search_bar.dart';
import '../resources/widgets/molecules/topbar.dart';
import 'new_chat_page.dart';
import 'chat_screen.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<StatefulWidget> createState() => _MessageScreenState();
}

DatabaseService db = DatabaseService();
FirebaseAuth auth = FirebaseAuth.instance;

class _MessageScreenState extends State<MessagesScreen> {
  final Faker faker = Faker();
  final date = Helpers.randomDate();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBarChat(
        title: 'Chats',
        goToPage: () => showModalBottomSheet(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            ),
            context: context,
            builder: (BuildContext context) {
              return const NewChatWidget();
            }),
      ),
      body: StreamBuilder<List<AppUser>>(
          stream: readUsers(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasError) {
                return Text('Something went wrong! ${snapshot.error}');
              }
            }
            if (snapshot.hasData) {
              final users = snapshot.data!;
              return
                  //CustomScrollView(
                  // slivers: [
                  //const SliverToBoxAdapter(
                  //child: _Connections(),
                  //),
                  //SliverList
                  ListView(
                children: users.map(buildUser).toList(),
                //),
                //],
              );
            }
            return const Center(
              child: CircularProgressIndicator(
                color: TravalongColors.secondary_10,
              ),
            );
          }),
    );
  }

  // Stream to get list of users in firebase
  Stream<List<AppUser>> readUsers() =>
      db.userCollection.snapshots().map((list) => list.docs
          .map((doc) => AppUser.newfromJSON(doc.data() as Map<String, dynamic>))
          .toList());

  Widget buildUser(AppUser user) => ListTile(
        leading: CircleAvatar(child: Text(Helpers.randomPictureUrl())),
        title: Text(user.name!),
        subtitle: Text(faker.lorem.sentence()),
      );

  // ! Not using currently
  Widget _delegate(
    BuildContext context,
    int index,
  ) {
    return _MessageTile(
      messageData: MessageData(
        senderName: 'name',
        message: faker.lorem.sentence(),
        messageDate: date,
        dateMessage: Jiffy(date).fromNow(),
        profilePicture: Helpers.randomPictureUrl(),
      ),
    );
  }
}

// ! Not using currently
class _MessageTile extends StatefulWidget {
  const _MessageTile({
    Key? key,
    required this.messageData,
  }) : super(key: key);

  final MessageData messageData;

  @override
  State<_MessageTile> createState() => _MessageTileState();
}

class _MessageTileState extends State<_MessageTile> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(ChatScreen.route(widget.messageData));
      },
      child: Container(
        height: 95,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: TravalongColors.neutral_60,
          border: Border(
            bottom: BorderSide(
              color: Theme.of(context).dividerColor,
              width: 0.5,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Avatar.large(url: widget.messageData.profilePicture),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                      child: Text(
                        widget.messageData.senderName,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          letterSpacing: 0.2,
                          wordSpacing: 1.5,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                      child: Text(
                        widget.messageData.message,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      widget.messageData.dateMessage.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 11,
                        letterSpacing: -0.2,
                        fontWeight: FontWeight.w600,
                        color: Colors.red,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      width: 18,
                      height: 18,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Text(
                          '1',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Connections extends StatelessWidget {
  const _Connections({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: SafeArea(
          child: Card(
            color: TravalongColors.neutral_60,
            elevation: 0,
            child: SizedBox(
              height: 180,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 12.0, left: 12, right: 12),
                    child: SearchBar(),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16, right: 16, top: 16),
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
                                  color: TravalongColors.secondary_text_dark,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 10),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: 4, // !Number of connections
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        final faker = Faker();
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: 60,
                            child: _ConnectionCard(
                              storyData: StoryData(
                                name: faker.person.firstName(),
                                url: Helpers.randomPictureUrl(),
                              ),
                            ),
                          ),
                        );
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

class _ConnectionCard extends StatelessWidget {
  const _ConnectionCard({
    Key? key,
    required this.storyData,
  }) : super(key: key);

  final StoryData storyData;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Avatar.medium(url: storyData.url),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              storyData.name,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 10,
                letterSpacing: 0.2,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
