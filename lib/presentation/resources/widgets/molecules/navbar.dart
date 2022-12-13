import 'package:flutter/material.dart';
import 'package:travalong/presentation/chat_screens/messages_screen.dart';
import 'package:travalong/presentation/resources/colors.dart';

import '../../../profile_screens/profile_page.dart';

// TODO: Slet denne class

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedIndex = 0;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static const List<Widget> _widgetOptions = <Widget>[
    MessagesScreen(),
    MessagesScreen(), // ! Search skal være her
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      iconSize: 40,
      backgroundColor: Colors.white,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.person_search_outlined),
          label: 'Search',
          backgroundColor: Colors.white,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat_bubble_outline_rounded),
          label: 'Chat',
          backgroundColor: Colors.white,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: 'Profile',
          backgroundColor: Colors.white,
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: TravalongColors.secondary_10,
      onTap: _onItemTapped,
    );
  }
}
