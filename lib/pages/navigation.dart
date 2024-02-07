import 'package:flutter/material.dart';
import 'package:mobirural/constants/appconstants.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobirural/services/map_service.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  GoogleMapController? mapController;
  LatLng? userLocation;
  Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _loadMarkers();
  }

  Future<void> _loadMarkers() async {
    Set<Marker> markers = await MapService().getBuildingMarkers();
    setState(() {
      _markers = markers;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: GoogleMap(
          onMapCreated: (controller) async {
            mapController = controller;
            await _setMapStyle();
          },
          initialCameraPosition: const CameraPosition(
            target: LatLng(-8.0169873, -34.946948),
            zoom: 15.0,
          ),
          markers: _markers,
          zoomControlsEnabled: false,
          myLocationEnabled: true,
          compassEnabled: true,
          onCameraMove: (CameraPosition position) {
            userLocation = position.target;
          },
        ));
  }

  Future<void> _setMapStyle() async {
    String style = await DefaultAssetBundle.of(context)
        .loadString('assets/maps/silver.json');
    mapController?.setMapStyle(style);
  }
}
