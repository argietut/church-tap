import 'package:bethel_app_final/constant/colors.dart';
import 'package:bethel_app_final/screen_pages/event_page.dart';
import 'package:bethel_app_final/screen_pages/home_page.dart';
import 'package:bethel_app_final/screen_pages/message_page.dart';
import 'package:bethel_app_final/screen_pages/profile_page.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentTab = 0;
  final List<StatefulWidget> _children = [
    const HomeScreen(),
    const Events(),
    const Messages(),
    const Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFE7EBEE),
      body: SafeArea(
        child: _children[_currentTab],
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 6,
        backgroundColor: Colors.grey[400], // Set the background color to grey
        selectedItemColor: Constants.green,
        unselectedItemColor: Colors.grey[800],
        type: BottomNavigationBarType.fixed,
        iconSize: 10.0, // Adjust the icon size
        selectedFontSize: 12.0, // Adjust the font size for selected items
        unselectedFontSize: 12.0, // Adjust the font size for unselected items
        onTap: (int value) {
          setState(() {
            _currentTab = value;
          });
        },
        currentIndex: _currentTab,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 20,
            ),
            label: 'Home',
            activeIcon: Text(
              "HOME",
              style: TextStyle(fontSize: 8),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.event_available_outlined,
              size: 20,
            ),
            label: 'Events',
            activeIcon: Text(
              "EVENTS",
              style: TextStyle(fontSize: 8),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.message_outlined,
              size: 20,
            ),
            label: 'Messages',
            activeIcon: Text(
              "MESSAGES",
              style: TextStyle(fontSize: 8),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_outline,
              size: 20,
            ),
            label: 'Profile',
            activeIcon: Text(
              "PROFILE",
              style: TextStyle(fontSize: 8),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle the onPressed event
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.blue, // Customize the background color
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
