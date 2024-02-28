//https://github.com/rorystephenson/flutter_map_marker_popup/blob/master/example/lib/example_popup_with_data.dart
// REFERENCE STARTS IN LINE 83
// Making your own Widget extended in Marker. super smart solution by the creator of the library!
import 'package:bethel_app_final/FRONT_END/MemberScreens/map_components/Geolocator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class Monument {
  static const double size = 50;

  Monument(
      {required this.name,
      required this.imagePath,
      required this.latitude,
      required this.longitude});

  final String name;
  final String imagePath;
  final double latitude;
  final double longitude;
}

class MonumentMarker extends Marker {
  final Monument monument;

  MonumentMarker({required this.monument})
      : super(
            alignment: Alignment.topCenter,
            height: Monument.size,
            width: Monument.size,
            point: LatLng(monument.latitude, monument.longitude),
            child: Image.asset("assets/images/churchmarker.png"));
}

class MonumentMarkerPopup extends StatelessWidget {
  const MonumentMarkerPopup({super.key, required this.monument});
  final Monument monument;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 500,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(monument.name),
              Image.asset(
                monument.imagePath,
                width: 200,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () => Geolocate(),//This Must be Get user Location then throw it to API
                      child: Row(children: [
                        Icon(Icons.directions),
                        Text("    Directions")
                      ]
                      )
                  )
                ],
              )
            ]),
      ),
    );
  }
}
