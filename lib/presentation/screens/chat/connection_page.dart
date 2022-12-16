import 'package:flutter/material.dart';
import 'package:travalong/presentation/resources/widgets/atoms/back_arrow.dart';

import '../../resources/widgets/molecules/search_bar.dart';
import '../../resources/widgets/molecules/topbar.dart';

class ConnectionPage extends StatefulWidget{
  const ConnectionPage({super.key});

  @override
  State<StatefulWidget> createState() => _ConnectionPageState();
}

class _ConnectionPageState extends State<ConnectionPage>{

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: TopBar(
        title: "Connections", leading: BackArrow(),
      ),
      body: Center(child: SearchBar()),
    );
  }
}