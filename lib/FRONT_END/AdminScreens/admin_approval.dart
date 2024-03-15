import 'package:bethel_app_final/FRONT_END/AdminScreens/widget_admin/sort_approval.dart';
import 'package:bethel_app_final/FRONT_END/MemberScreens/widget_member/sort_icon.dart';
import 'package:bethel_app_final/FRONT_END/constant/color.dart';
import 'package:flutter/material.dart';

class AdminApproval extends StatefulWidget {
  const AdminApproval({Key? key}) : super(key: key);

  @override
  State<AdminApproval> createState() => _AdminApprovalState();
}

class _AdminApprovalState extends State<AdminApproval> {
  bool hasEvents = false; // Assume no events initially
  SortingButton sortingButton = SortingButton();

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
              sortingButton.buildIconButton(onPressed: () {
                // Handle sorting logic here
                sortingButton.toggleSortingOption();
                // Implement sorting logic here based on sortingButton.currentSortingOption
                if (sortingButton.currentSortingOption == ApprovalSortingOption.Month) {
                  // Sort by month
                  // Your sorting logic here...
                } else {
                  // Sort by week
                  // Your sorting logic here...
                }
              }),
              const SizedBox(width: 15),
              const Text(
                "Admin Approval",
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
              'No appointment requests yet!',
              style: TextStyle(
                fontSize: 20 ,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Time to chill and find your self yet.',
            ),
            const SizedBox(height: 20),

          ],
        ),
      ),
    );
  }
}
