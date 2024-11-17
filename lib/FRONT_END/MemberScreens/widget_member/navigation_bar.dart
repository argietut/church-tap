import 'package:bethel_app_final/BACK_END/Services/Functions/Authentication.dart';
import 'package:bethel_app_final/BACK_END/Services/Functions/Users.dart';
import 'package:bethel_app_final/FRONT_END/MemberScreens/home_page.dart';
import 'package:bethel_app_final/FRONT_END/MemberScreens/profile_page.dart';
import 'package:bethel_app_final/FRONT_END/MemberScreens/widget_member/Calendar.dart';
import 'package:bethel_app_final/FRONT_END/MemberScreens/eventPage .dart';
import 'package:bethel_app_final/FRONT_END/MemberScreens/NotificationTab.dart';
import 'package:bethel_app_final/FRONT_END/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _bottomNavIndex = 0; // To track the current tab
  int _notificationCount = 0; // Notification count
  final List<Widget> _children = [
    const MemberHomePage(),
    const EventPage(),
    const NotificationTab(),
    const Profile(),
  ];

  // Icon list for the bottom navigation bar
  final List<IconData> _iconList = [
    Icons.home_sharp,
    Icons.event,
    Icons.notifications,
    Icons.person,
  ];

  @override
  void initState() {
    super.initState();
    _updateNotificationCount();
  }

  void _updateNotificationCount() {
    UserStorage().getNotification(TapAuth().auth.currentUser!.uid).listen((snapshot) {
      setState(() {
        _notificationCount = snapshot.docs.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: _children[_bottomNavIndex],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: appWhite,
        elevation: 0,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CustomCalendar(type: "members")),
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        backgroundColor: appGreen2,
        icons: _iconList,
        activeIndex: _bottomNavIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.verySmoothEdge,
        onTap: (index) {
          setState(() {
            _bottomNavIndex = index;
          });
        },
        activeColor: appBlack,
        inactiveColor: appWhite,
        leftCornerRadius: 32,
        rightCornerRadius: 32,
      ),
    );
  }
}
