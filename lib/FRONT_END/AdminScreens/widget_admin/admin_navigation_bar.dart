import 'package:bethel_app_final/FRONT_END/AdminScreens/admin_approval.dart';
import 'package:bethel_app_final/FRONT_END/AdminScreens/admin_home.dart';
import 'package:bethel_app_final/FRONT_END/AdminScreens/admin_setting.dart';
import 'package:bethel_app_final/FRONT_END/MemberScreens/widget_member/Calendar.dart';
import 'package:bethel_app_final/FRONT_END/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';

class AdminNavigationPage extends StatefulWidget {
  const AdminNavigationPage({Key? key}) : super(key: key);

  @override
  _AdminNavigationPageState createState() => _AdminNavigationPageState();
}

class _AdminNavigationPageState extends State<AdminNavigationPage> {
  int _currentTab = 0;
  final List<Widget> _children = [
    const AdminHomePage(),
    const AdminApproval(),
    const CustomCalendar(type: "admins"),
    const AdminSettings(),
  ];

  // Define icons and labels for the AnimatedBottomNavigationBar
  final List<Map<String, dynamic>> _navItems = [
    {"icon": Icons.event, "label": "Events"},
    {"icon": Icons.check_circle_outline_sharp, "label": "Approval"},
    {"icon": Icons.calendar_month, "label": "Calendar"},
    {"icon": Icons.settings, "label": "Settings"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _children[_currentTab],
      ),
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        backgroundColor: appWhite,
        elevation: 4,
        onPressed: () {
          // Add your custom action for the FAB here
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CustomCalendar(type: "admins")),
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
        activeIndex: _currentTab,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.verySmoothEdge,
        leftCornerRadius: 32,
        rightCornerRadius: 32,
        onTap: (index) {
          setState(() {
            _currentTab = index;
          });
        },
      ),
    );
  }
}
