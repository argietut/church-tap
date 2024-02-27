import 'package:bethel_app_final/FRONT_END/MemberScreens/map_components/Monument.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';

class CustomMarkerPop extends StatefulWidget {
  const CustomMarkerPop({super.key});

  @override
  State<CustomMarkerPop> createState() => _CustomMarkerPopState();
}

class _CustomMarkerPopState extends State<CustomMarkerPop> {
  @override
  Widget build(BuildContext context) {
    return PopupMarkerLayer(
        options: PopupMarkerLayerOptions(
            popupDisplayOptions: PopupDisplayOptions(
                builder: (_, Marker marker) {
                  if (marker is MonumentMarker) {
                    return MonumentMarkerPopup(monument: marker.monument);
                  }
                  return const Card(child: Text('Not a monument'));
                }
                ),//insert popupcard
            markerTapBehavior: MarkerTapBehavior.togglePopupAndHideRest(),
            markers: <Marker>[
              MonumentMarker(
                  monument: Monument(
                      name: "UCCP Magatos - Asuncion",
                      imagePath: "assets/images/churchMagatos.jpg",
                      latitude: 7.555150079680289,
                      longitude: 125.72685344854611)
              ),
              MonumentMarker(
                  monument: Monument(
                      name: "UCCP San Vicente - Asuncion",
                      imagePath: "assets/images/churchasuncion.jpg",
                      latitude: 7.537059099471106,
                      longitude: 125.75195318694657)
              ),
              MonumentMarker(
                  monument: Monument(
                      name: "UCCP Laak",
                      imagePath: "assets/images/churchlaak.jpg",
                      latitude: 7.819575741772514,
                      longitude: 125.79286971801396)
              )
            ]
        )
    );
  }
}

