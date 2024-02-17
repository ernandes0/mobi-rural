import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobirural/models/building_model.dart';
import 'package:mobirural/models/obstacle_model.dart';
import 'package:mobirural/services/building_service.dart';
import 'package:mobirural/services/obstacle_service.dart';

class MapService {
  Future<Set<Marker>> getBuildingMarkers() async {
    Set<Marker> markers = {};
    List<Building> buildings = await BuildingService().getBuildings();

    for (Building building in buildings) {
      if (building.coordinates != null) {
        LatLng position = LatLng(
            building.coordinates!.latitude, 
            building.coordinates!.longitude
            );
        Marker marker = Marker(
          markerId: MarkerId(building.id!),
          position: position,
          icon: await BitmapDescriptor.fromAssetImage(
              const ImageConfiguration(size: Size(3, 3)),
              'assets/building.png'),
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

  Future<Set<Marker>> getObstacleMarkers() async {
    Set<Marker> markers = {};
    List<ObstacleModel> obstacles = await ObstacleService().getObstacles();

    for (ObstacleModel obstacle in obstacles) {
      if (obstacle.coordinates != null) {
        LatLng position = LatLng(
          obstacle.coordinates!.latitude,
          obstacle.coordinates!.longitude,
        );

        Marker marker = Marker(
          markerId: MarkerId(obstacle.id!),
          position: position,
          icon: await BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(size: Size(3, 3)),
            'assets/obstacle.png',
          ),
          infoWindow: InfoWindow(
            title: 'Obstáculo',
            snippet: obstacle.title ?? '',
          ),
        );

        markers.add(marker);
      }
    }

    return markers;
  }
}
