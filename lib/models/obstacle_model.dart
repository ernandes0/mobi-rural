import 'package:cloud_firestore/cloud_firestore.dart';

class ObstacleModel {
  String? id;
  String? userId;
  String? userName;
  GeoPoint? coordinates;
  String? title;
  String? details;
  int? difficulty;

  ObstacleModel({
    this.id,
    required this.userId,
    required this.userName,
    required this.coordinates,
    required this.title,
    required this.details,
    required this.difficulty,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'userName': userName,
      'coordinates': coordinates,
      'title': title,
      'details': details,
      'difficulty': difficulty,
    };
  }

  factory ObstacleModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return ObstacleModel(
      id: snapshot.id,
      userId: data['userId'],
      userName: data['userName'],
      coordinates: data['coordinates'],
      title: data['title'],
      details: data['details'],
      difficulty: data['difficulty'],
    );
  }
}
