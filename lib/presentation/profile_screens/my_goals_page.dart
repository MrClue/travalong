import "package:flutter/material.dart";

import "../widgets/molecules/topbar.dart";

class MyGoalsPage extends StatelessWidget {
  const MyGoalsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        title:"My Goals",
      ),
    );
  }
}
