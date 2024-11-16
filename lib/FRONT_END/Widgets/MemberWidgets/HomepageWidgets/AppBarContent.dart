import 'package:bethel_app_final/FRONT_END/MemberScreens/screen_pages/home_screen_pages/mapstoragescreen.dart';
import 'package:bethel_app_final/FRONT_END/MemberScreens/screen_pages/home_screen_pages/search_button_details.dart';
import 'package:bethel_app_final/FRONT_END/constant/color.dart';
import 'package:flutter/material.dart';

class AppBarContent extends StatelessWidget {
  final VoidCallback onSortPressed;

  const AppBarContent({required this.onSortPressed, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: 20.0,
          right: 20.0,
          top: 40.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: onSortPressed,
                style: IconButton.styleFrom(
                  shape: const CircleBorder(
                    side: BorderSide(color: appGrey, width: 1),
                  ),
                ),
                icon: const Icon(Icons.sort),
              ),
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
                  tag: '',
                  child: SearchButton(isSearching: false),
                ),
              ),
            ],
          ),
        ),
        const Positioned(
          left: 20.0,
          right: 20.0,
          top: 110.0,
          child: Divider(
            color: appGreen,
          ),
        ),
      ],
    );
  }
}
