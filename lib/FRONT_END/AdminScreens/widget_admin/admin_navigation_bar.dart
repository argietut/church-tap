import 'package:bethel_app_final/FRONT_END/AdminScreens/admin_events.dart';
import 'package:bethel_app_final/FRONT_END/AdminScreens/admin_home.dart';
import 'package:bethel_app_final/FRONT_END/AdminScreens/AdminEvents.dart';
import 'package:bethel_app_final/FRONT_END/MemberScreens/appointment_page.dart';
import 'package:bethel_app_final/FRONT_END/MemberScreens/event_page.dart';
import 'package:bethel_app_final/FRONT_END/MemberScreens/home_page.dart';
import 'package:bethel_app_final/FRONT_END/constant/color.dart';
import 'package:flutter/material.dart';

class AdminNavigationPage extends StatefulWidget {
  const AdminNavigationPage({Key? key}) : super(key: key);

  @override
  _AdminNavigationPageState createState() => _AdminNavigationPageState();
}

class _AdminNavigationPageState extends State<AdminNavigationPage> {
  int _currentTab = 0;
  final List<StatefulWidget> _children = [
    const AdminHomePage(),
    const Events(),

    // const Notifications(),
    // const Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appWhite,
      body: SafeArea(
        child: _children[_currentTab],
      ),
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        color: appWhite,
        child: BottomNavigationBar(
          elevation: 5,
          backgroundColor: appGreen,
          selectedItemColor: appWhite,
          unselectedItemColor: appWhite,
          type: BottomNavigationBarType.fixed,
          iconSize: 20.0,
          selectedFontSize: 12.0,
          unselectedFontSize: 12.0,
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
                "",
                style: TextStyle(fontSize: 8, color: appWhite),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.event_available,
                size: 20,
              ),
              label: 'Events',
              activeIcon: Text(
                "",
                style: TextStyle(fontSize: 8),
              ),
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(
            //     Icons.message,
            //     size: 20,
            //   ),
            //   label: 'Messages',
            //   activeIcon: Text(
            //     "",
            //     style: TextStyle(fontSize: 8),
            //   ),
            // ),
            // BottomNavigationBarItem(
            //   icon: Icon(
            //     Icons.person,
            //     size: 20,
            //   ),
            //   label: 'Profile',
            //   activeIcon: Text(
            //     "",
            //     style: TextStyle(fontSize: 8),
            //   ),
            // ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        margin: const EdgeInsets.only(top: 10),
        height: 64,
        width: 64,
        child: FloatingActionButton(
          backgroundColor: appWhite,
          elevation: 0,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AdminAppointmentPage()),
            );
          },
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 3, color: appGreen),
            borderRadius: BorderRadius.circular(100),
          ),
          child: const Icon(
            Icons.add,
            color: appGreen,
          ),
        ),
      ),
    );
  }
}

