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

  final List<Map<String, dynamic>> _navItems = [
    {"icon": Icons.home_sharp, "label": "Home"},
    {"icon": Icons.event, "label": "Events"},
    {"icon": Icons.notifications, "label": "Notifications"},
    {"icon": Icons.person, "label": "Profile"},
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
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        backgroundColor: appGreen2,
        itemCount: _navItems.length,
        tabBuilder: (int index, bool isActive) {
          final color = isActive ? appBlack : appWhite.withOpacity(0.6);
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                _navItems[index]["icon"],
                size: 24,
                color: color,
              ),
              const SizedBox(height: 4),
              Text(
                _navItems[index]["label"],
                style: TextStyle(
                  fontSize: 12,
                  color: color,
                ),
              ),
            ],
          );
        },
        activeIndex: _bottomNavIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.verySmoothEdge,
        leftCornerRadius: 32,
        rightCornerRadius: 32,
        onTap: (index) {
          setState(() {
            _bottomNavIndex = index;
          });
        },
      ),
    );
  }
}
