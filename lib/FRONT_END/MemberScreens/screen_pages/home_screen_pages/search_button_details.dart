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
        horizontal:55,
        vertical: 12.0,
      ),
      alignment: Alignment.centerRight,
      decoration: BoxDecoration(
        color: appWhite,
        border: Border.all(
          color: appGrey,
          width: 1.0,

        ),
        borderRadius: BorderRadius.circular(32.0),
        boxShadow: [
          // BoxShadow(
          //   color: appGrey.withOpacity(0.5),
          //   // blurRadius: 2.0,
          //   spreadRadius: 2.0,
          //   // offset: const Offset(0, 1.0),
          // )
        ],
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.end,
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