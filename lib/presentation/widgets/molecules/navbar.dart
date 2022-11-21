import 'package:flutter/material.dart';
import 'package:travalong/presentation/screens/start_screen.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);


  @override
  _NavBarState createState() => _NavBarState();
}

Color buttonColor = Color(0xFF2ABAFF);

class _NavBarState extends State<NavBar>{
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    StartScreen(),
    // Profile
    // Search
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
          icon: Icon(Icons.person_2_outlined),
          label: 'Profile',
          backgroundColor: Colors.white,
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: buttonColor,
      onTap: _onItemTapped,
    );
  }
}