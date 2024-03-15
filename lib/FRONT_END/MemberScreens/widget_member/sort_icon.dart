import 'package:bethel_app_final/FRONT_END/constant/color.dart';
import 'package:flutter/material.dart';

enum SortingOption {
  Month,
  Week,
}

class SortingButton {
  SortingOption _currentSortingOption = SortingOption.Month;

  SortingOption get currentSortingOption => _currentSortingOption;

  void toggleSortingOption() {
    _currentSortingOption = _currentSortingOption == SortingOption.Month
        ? SortingOption.Week
        : SortingOption.Month;
  }

  Widget buildIconButton({required VoidCallback onPressed}) {
    return IconButton(
      onPressed: onPressed,
      style: IconButton.styleFrom(
        shape: const CircleBorder(
          side: BorderSide(
            color: appGrey,
            width: 1.0,
          ),
        ),
      ),
      icon: const Icon(Icons.sort),
    );
  }
}