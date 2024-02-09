import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobirural/models/obstacle_model.dart';

class ObstacleService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createObstacle(ObstacleModel obstacle) async {
    try {
      await _firestore.collection('obstacles').add(obstacle.toMap());
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ObstacleModel>> getObstacles() async {
    try {
      QuerySnapshot querySnapshot =
          await _firestore.collection('obstacles').get();

      return querySnapshot.docs
          .map((doc) => ObstacleModel.fromSnapshot(doc))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateObstacle(ObstacleModel obstacle) async {
    try {
      await _firestore
          .collection('obstacles')
          .doc(obstacle.id)
          .update(obstacle.toMap());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteObstacle(String obstacleId) async {
    try {
      await _firestore.collection('obstacles').doc(obstacleId).delete();
    } catch (e) {
      rethrow;
    }
  }
}
