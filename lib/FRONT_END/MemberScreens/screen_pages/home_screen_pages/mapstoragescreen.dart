import 'dart:ui';
import 'package:bethel_app_final/FRONT_END/MemberScreens/map_components/map_page.dart';
import 'package:bethel_app_final/FRONT_END/constant/color.dart';
import 'package:flutter/material.dart';

class MapStorageScreen extends StatefulWidget {
  const MapStorageScreen({Key? key}) : super(key: key);

  @override
  State<MapStorageScreen> createState() => _MapStorageScreenState();
}

class _MapStorageScreenState extends State<MapStorageScreen> {

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 8.0,
          sigmaY: 8.0,
        ),
        child: Container(
          padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBar(
                automaticallyImplyLeading: false,
                leading: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close),
                ),
                title: const Text(
                  "Locate outreach churches",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              const Divider(
                color: appGreen,
              ),
              const Expanded(
                child: MapPage(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
