import 'package:flutter/material.dart';
import 'package:mobirural/models/building_model.dart';
import 'package:mobirural/pages/buildingdetails.dart';

class BuildingCard extends StatelessWidget {
  final Building building;

  const BuildingCard({super.key, required this.building});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BuildingDetailsScreen(building: building),
          ),
        );
      },
    child: Card(
      semanticContainer: true,
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 4.0,
      child: SizedBox(
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              building.icon ?? '',
              height: 90,
              width: 90,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 16.0),
            Text(
              building.name ?? 'Nome não disponível',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
