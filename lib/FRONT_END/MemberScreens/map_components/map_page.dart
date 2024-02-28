import 'package:bethel_app_final/FRONT_END/MemberScreens/map_components/Geolocator.dart';
import 'package:bethel_app_final/FRONT_END/MemberScreens/map_components/marker_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class MapPage extends StatefulWidget {

  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final Geolocate geolocate = Geolocate();
  late final Future _future = positionReveal(); //FIX FOR FUTUREBUILDER CONSTANTLY GETTING CALLED
  final mapController = MapController();
  var _userlat = 0.0;
  var _userlong = 0.0;
  @override
  void initState() {
  CurrentLocationLayer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: FutureBuilder(future: _future, builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            else if(snapshot.hasError){
            const SnackBar(content: Text("Loading Map Failed!"));
            }
            return FlutterMap(
              options: MapOptions(
                  initialCenter: LatLng(_userlat, _userlong),
                  initialZoom: 15),
              mapController: mapController,
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.app',
                  subdomains: const ['a', 'b', 'c'],
                ),
                CurrentLocationLayer(),
                const CustomMarkerPop(),
              ],);
          }
          ,),
        )
    );

    }
Future<double> positionReveal() async{
    Position position = await geolocate.determinePosition();
    setState(() {
      _userlat = position.latitude;
      _userlong = position.longitude;
    });
    return 2;

  }
}