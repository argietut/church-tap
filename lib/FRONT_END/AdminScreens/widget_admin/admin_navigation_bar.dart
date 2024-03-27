import 'package:bethel_app_final/FRONT_END/AdminScreens/admin_approval.dart';
import 'package:bethel_app_final/FRONT_END/AdminScreens/admin_home.dart';
import 'package:bethel_app_final/FRONT_END/AdminScreens/admin_setting.dart';
import 'package:bethel_app_final/FRONT_END/MemberScreens/widget_member/Calendar.dart';
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
    const AdminApproval(),
    const CustomCalendar(type: "admins"),
    const AdminSettings(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appGreen,
      body: SafeArea(
        child: _children[_currentTab],
      ),
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        color: appGreen,
        child: BottomNavigationBar(
          elevation: 6,
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
                Icons.event_available,
                size: 20,
              ),
              label: 'Events',
              activeIcon: Text(
                "",
                style: TextStyle(fontSize: 8, color: appWhite),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.check,
                size: 20,
              ),
              label: 'Approval',
              activeIcon: Text(
                "",
                style: TextStyle(fontSize: 8),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.calendar_month,
                size: 20,
              ),
              label: 'Calendar',
              activeIcon: Text(
                "",
                style: TextStyle(fontSize: 8),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.settings,
                size: 20,
              ),
              label: 'Settings',
              activeIcon: Text(
                "",
                style: TextStyle(fontSize: 8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

