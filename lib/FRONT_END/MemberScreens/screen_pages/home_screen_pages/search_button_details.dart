import 'package:bethel_app_final/FRONT_END/constant/color.dart';
import 'package:flutter/material.dart';

class SearchButton extends StatelessWidget {
  final bool isSearching;

  const SearchButton({
    Key? key,
    required this.isSearching,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 10.0,
      ),
      decoration: BoxDecoration(
        color: appWhite,
        border: Border.all(
          color: appGrey,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(32.0),
        boxShadow: [
          BoxShadow(
            color: appGrey.withOpacity(0.5),
            blurRadius: 8.0,
            spreadRadius: 8.0,
            offset: const Offset(0, 4.0),
          )
        ],
      ),
      child: const Row(
        children: [
          Icon(Icons.search),
          SizedBox(width: 8.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Locate outreach',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          )
        ],
      ),
    );
  }
}