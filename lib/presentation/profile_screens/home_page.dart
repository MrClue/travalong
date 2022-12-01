import 'package:flutter/material.dart';
import 'package:travalong/presentation/chat_screens/messages_screen.dart';
import 'package:travalong/presentation/profile_screens/profile_page.dart';
import 'package:travalong/presentation/resources/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomePage>{
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    MessagesScreen(),
    MessagesScreen(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 40,
        items: items(),
        currentIndex: _selectedIndex,
        selectedItemColor: TravalongColors.secondary_10,
        onTap: _onItemTapped,
      ),
      body: HomePageWidget(
        widgetOptions: _widgetOptions, 
        selectedIndex: _selectedIndex),
    );
  }

  // Nav bar elements
  List<BottomNavigationBarItem> items() {
    return const <BottomNavigationBarItem>[
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
      ];
  }
}

class HomePageWidget extends StatelessWidget {
  const HomePageWidget({
    super.key,
    required List<Widget> widgetOptions,
    required int selectedIndex,
  }) : _widgetOptions = widgetOptions, _selectedIndex = selectedIndex;

  final List<Widget> _widgetOptions;
  final int _selectedIndex;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
    );
  }
}