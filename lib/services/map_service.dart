import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobirural/models/building_model.dart';
import 'package:mobirural/services/building_service.dart';

class MapService {
  Future<Set<Marker>> getBuildingMarkers() async {
    Set<Marker> markers = {};
    List<Building> buildings = await BuildingService().getBuildings();

    for (Building building in buildings) {
      if (building.coordinates != null) {
        LatLng position = LatLng(
            building.coordinates!.latitude, building.coordinates!.longitude);

        // Criar um marcador personalizado com um ícone da pasta assets
        Marker marker = Marker(
          markerId: MarkerId(building.id!),
          position: position,
          icon: await BitmapDescriptor.fromAssetImage(
              const ImageConfiguration(size: Size(3, 3)), 'assets/building.png'),
          infoWindow: InfoWindow(
            title: building.name ?? '',
            snippet: 'Descrição do edifício aqui',
          ),
        );

        markers.add(marker);
      }
    }

    return markers;
  }
}
