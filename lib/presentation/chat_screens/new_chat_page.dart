import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travalong/presentation/resources/widgets/atoms/back_arrow.dart';

import '../resources/widgets/molecules/topbar.dart';

class NewChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(title: 'New Chat', leading: BackArrow(),),
    );
  }

}