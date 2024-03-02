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
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.close),
        ),
        // actions: const [SizedBox(width: 48)],
      ),
      body: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 8.0,
          sigmaY: 8.0,
        ),
        child: Container(
          // color: appWhite.withOpacity(0.5),
          padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Locate outreach churches",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // SizedBox(width: 50),
                ],
              ),
              SizedBox(height: 15),
              Divider(
                color: appGreen,
              ),
              Expanded(
                child: MapPage(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
