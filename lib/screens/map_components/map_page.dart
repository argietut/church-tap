
import 'package:bethel_app_final/screens/map_components/customer_marker.dart';
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
  late Future _future = _getLatitude(); //FIX FOR FUTUREBUILDER CONSTANTLY GETTING CALLED
  final mapController = MapController();
  var _userlat = 0.0;
  var _userlong = 0.0;
  @override
  void initState() {
  CurrentLocationLayer();
  _determinePosition();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(future: _future, builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          else if(snapshot.hasError){
          const SnackBar(content: Text("Loading Map Failed!"));
          }
          return FlutterMap(
            options: MapOptions(
                onMapReady: () {
                },
                initialCenter: LatLng(_userlat, _userlong),
                initialZoom: 15),
            mapController: mapController,
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.app',
                subdomains: ['a', 'b', 'c'],
              ),
              CurrentLocationLayer(),
              const CustomMarker(),
            ],);
        }
        ,)
    );

    }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }
  Future<double> _getLatitude() async{
    Position pos = await _determinePosition();
    setState(() {
      _userlat = pos.latitude;
      _userlong = pos.longitude;
    });
    return _userlat;
  }
}

/*FlutterMap(
options: MapOptions(
onMapReady: () {
},
initialCenter: LatLng(_userlat, _userlong),
initialZoom: 5),
mapController: mapController,
children: [
TileLayer(
urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
userAgentPackageName: 'com.example.app',
subdomains: ['a', 'b', 'c'],
),
CurrentLocationLayer(),
CustomMarker(),
Text("$_userlong",style: TextStyle(fontSize: 64),),
Text("$_userlat")
],)*/