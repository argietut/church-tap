import 'package:bethel_app_final/BACK_END/Services/Functions/Users.dart';

import 'package:bethel_app_final/FRONT_END/MemberScreens/screen_pages/home_screen_pages/mapstoragescreen.dart';
import 'package:bethel_app_final/FRONT_END/MemberScreens/screen_pages/home_screen_pages/search_button_details.dart';
import 'package:bethel_app_final/FRONT_END/Widgets/MemberWidgets/HomepageWidgets/AppBarContent.dart';
import 'package:bethel_app_final/FRONT_END/Widgets/MemberWidgets/HomepageWidgets/EventDropdownWidget.dart';
import 'package:bethel_app_final/FRONT_END/Widgets/MemberWidgets/HomepageWidgets/EventListWidget.dart';

import 'package:bethel_app_final/FRONT_END/constant/color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MemberHomePage extends StatefulWidget {
  const MemberHomePage({Key? key}) : super(key: key);

  @override
  State<MemberHomePage> createState() => _MemberHomePageState();
}

class _MemberHomePageState extends State<MemberHomePage> {
  final UserStorage userStorage = UserStorage();
  String _selectedEventType = 'Upcoming';
  bool sortByMonth = false;
  bool sortByDay = false;
  int clickCount = 0;

  void toggleSortOrder() {
    setState(() {
      clickCount++;
      sortByMonth = clickCount % 2 == 1;
      sortByDay = !sortByMonth;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 120,
        flexibleSpace: AppBarContent(
          onSortPressed: toggleSortOrder,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            EventDropdownWidget(
              selectedValue: _selectedEventType,
              onChanged: (value) {
                setState(() {
                  _selectedEventType = value!;
                });
              },
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Church events',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            Expanded(
              child: EventListWidget(
                userStorage: userStorage,
                selectedEventType: _selectedEventType,
                sortByMonth: sortByMonth,
                sortByDay: sortByDay,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
