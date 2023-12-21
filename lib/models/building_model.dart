import 'package:cloud_firestore/cloud_firestore.dart';

class Building {
  final String? accessRamps;
  final String? adaptedBathroom;
  final GeoPoint? coordinates;
  final String? elevator;
  final String? floor;
  final String? icon;
  final String? name;
  final String? parking;
  final String? image;

  Building({
    this.accessRamps,
    this.adaptedBathroom,
    this.coordinates,
    this.elevator,
    this.floor,
    this.icon,
    this.name,
    this.parking,
    this.image,
  });

  factory Building.fromMap(Map<String, dynamic>? data) {
    if (data == null) {
      return Building();
    }
    return Building(
      accessRamps: data['access_ramps'],
      adaptedBathroom: data['adapted_bathroom'],
      coordinates: data['coordinates'],
      elevator: data['elevator'],
      floor: data['floor'],
      icon: data['icon'],
      name: data['name'],
      parking: data['parking'],
      image: data['image'],
    );
  }
}