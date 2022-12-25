import 'package:flutter/material.dart';
import 'package:travalong/presentation/resources/widgets/atoms/back_arrow.dart';
import 'package:travalong/presentation/resources/widgets/atoms/safe_scaffold.dart';
import 'package:travalong/presentation/resources/widgets/molecules/theme_topbar.dart';
import 'package:travalong/presentation/screens/search/widgets/view_profile_box.dart';

class ViewProfile extends StatelessWidget {
  final String? id;
  final String name;
  final int age;
  final String city;
  final String country;
  final String bio;
  final List<dynamic> interests;
  const ViewProfile(
      {super.key,
      this.id,
      required this.name,
      required this.age,
      required this.city,
      required this.country,
      required this.bio,
      required this.interests});

  @override
  Widget build(BuildContext context) {
    return SafeScaffold(
      topbar: ThemeTopBar(
        title: "View Profile",
        enableCustomButton: false,
        backArrow: const BackArrow(),
      ),
      child: Container(
        margin: const EdgeInsets.all(8),
        child: const Center(
          child: ViewProfileBox(
            name: 'NAME HERE',
            age: '25',
            bio: 'BIO',
            city: 'CITY',
            country: 'COUNTRY',
            interests: [],
            onPressed: null,
          ),
        ),
      ),
    );
  }
}
