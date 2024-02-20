import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class CustomMarker extends StatefulWidget {
  const CustomMarker({super.key});

  @override
  State<CustomMarker> createState() => _CustomMarkerState();
}

class _CustomMarkerState extends State<CustomMarker> {
  @override
  Widget build(BuildContext context) {
    var markers = <Marker>[];
    markers = [

      const Marker(
          point: LatLng(7.555136431276515, 125.7268561445927),
          child:
          Icon(
            Icons.church,
            color: Colors.green,
            size: 50,)),
      const Marker(
          point: LatLng(7.537497374130047, 125.75190973683117),
          child:
          Icon(
            Icons.church,
            color: Colors.red,
            size: 50,)),
      const Marker(
          point: LatLng(7.819664077444366, 125.79288009348033),
          child:
          Icon(
            Icons.church,
            color: Colors.red,
            size: 50,))
    ];
    return MarkerLayer(markers: markers);
  }
}