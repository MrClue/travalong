import 'package:flutter/material.dart';
import 'package:travalong/presentation/resources/widgets/atoms/safe_scaffold.dart';

import '../../resources/widgets/molecules/search_bar.dart';
import '../../resources/widgets/molecules/topbar.dart';

class ChatSearchPage extends StatefulWidget {
  const ChatSearchPage({super.key});

  @override
  State<StatefulWidget> createState() => _ChatSearchPageState();
}

class _ChatSearchPageState extends State<ChatSearchPage> {
  @override
  Widget build(BuildContext context) {
    return SafeScaffoldNoNavbar(
      topbar: TopBar(
        title: 'Chat',
      ),
      child: SearchBar(),
    );
  }
}
