import 'dart:ui';
import 'package:bethel_app_final/FRONT_END/MemberScreens/map_components/map_page.dart';
import 'package:bethel_app_final/FRONT_END/MemberScreens/screen_pages/home_screen_pages/mapstoragescreen.dart';
import 'package:bethel_app_final/FRONT_END/MemberScreens/widget_member/sort_icon.dart';
import 'package:bethel_app_final/FRONT_END/constant/color.dart';
import 'package:bethel_app_final/FRONT_END/MemberScreens/screen_pages/home_screen_pages/search_button_details.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MemberHomePage extends StatefulWidget {
  const MemberHomePage({Key? key}) : super(key: key);

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  State<MemberHomePage> createState() => _MemberHomePageState();
}


class _MemberHomePageState extends State<MemberHomePage> {
  bool _isSearching = false;
  SortingButton sortingButton = SortingButton();
  bool _isGreetingsShown = false; // Add a boolean flag


  // @override
  // void initState() {
  //   super.initState();
  //   Future.delayed(const Duration(seconds: 1), () {
  //     if (!_isGreetingsShown) { // Check if greetings have not been shown before
  //       _showWelcomeMessage();
  //     }
  //   });
  // }

  // void _showWelcomeMessage() {
  //   setState(() {
  //     _isGreetingsShown = true; // Update the flag to indicate that greetings have been shown
  //   });
  //
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: const Text('Welcome!'),
  //         content: const Text('Thank you for joining us!'),
  //         actions: <Widget>[
  //           TextButton(
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //             child: const Text('Close'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 120,
        flexibleSpace: Stack(
          children: [
            Positioned(
              left: 20.0,
              right: 20.0,
              top: 40.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  sortingButton.buildIconButton(onPressed: () {
                    // Handle sorting logic here
                    sortingButton.toggleSortingOption();
                    // Implement sorting logic here based on sortingButton.currentSortingOption
                    if (sortingButton.currentSortingOption == SortingOption.Month) {
                      // Sort by month
                      // Your sorting logic here...
                    } else {
                      // Sort by week
                      // Your sorting logic here...
                    }
                  }),

                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MapStorageScreen(),
                        ),
                      );
                    },
                    child: Hero(
                      tag: 'planning',
                      child: SearchButton(
                        isSearching: _isSearching,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Positioned(
              left: 20.0,
              right: 20.0,
              top: 110.0, // Adjust this value according to your design
              child: Divider(
                color: appGreen, // Change color according to your design
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
        child: Stack(
          children: [
            if (_isSearching)
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
                child: const Center(
                  child: MapPage(),
                ), // Display MapPage with blurred background when searching
              ),
            if (!_isSearching)
              const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'No Events Posted Yet',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Check back later for updates!',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}