import 'package:bethel_app_final/FRONT_END/constant/color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({Key? key}) : super(key: key);

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

void signUserOut() {
  FirebaseAuth.instance.signOut();
}

enum SortType { byDays, byWeeks, byMonths }

class _AdminHomePageState extends State<AdminHomePage> {
  SortType _sortType = SortType.byDays;

  void _sortBy(SortType sortType) {
    setState(() {
      _sortType = sortType;
    });
    print('Sorting by: $sortType');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    // Toggling sort order when IconButton is pressed
                    switch (_sortType) {
                      case SortType.byDays:
                        _sortBy(SortType.byWeeks);
                        break;
                      case SortType.byWeeks:
                        _sortBy(SortType.byMonths);
                        break;
                      case SortType.byMonths:
                        _sortBy(SortType.byDays);
                        break;
                    }
                  },
                  icon: const Icon(Icons.border_color_outlined),
                ),
                const Text(
                  "Admin Events",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 50),
              ],
            ),
            const SizedBox(height: 15),
            const Divider(
              color: appGreen,
            ),
            const SizedBox(height: 10),
            const Text(
              'No Events yet!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Time to chill and find yourself.',
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
