import "package:flutter/material.dart";
import "package:travalong/presentation/widgets/molecules/topbar.dart";

class MyProfilePage extends StatelessWidget {
  const MyProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        title: "My Profile",
      ),
    );
  }
}
