import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobirural/models/building_model.dart';

class BuildingService extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Building>> getBuildings() async {
    List<Building> buildings = [];

    try {
      QuerySnapshot querySnapshot = await _firestore.collection('buildings').get();
      
      for (var doc in querySnapshot.docs) {
        Building building = Building.fromMap(doc.data() as Map<String, dynamic>?);
        buildings.add(building);
      }

      return buildings;
    } catch (e) {
      debugPrint("Error fetching buildings: $e");
      return [];
    }
  }
}