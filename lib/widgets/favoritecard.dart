import 'package:flutter/material.dart';
import 'package:mobirural/constants/appconstants.dart';
import 'package:mobirural/models/building_model.dart';
import 'package:mobirural/pages/buildingdetails.dart';

class FavoriteBuildingCard extends StatelessWidget {
  final Building building;

  const FavoriteBuildingCard({super.key, required this.building});

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
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 100.0,
                height: 100.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                    image: NetworkImage(building.image ?? ''),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 12.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      building.name ?? '',
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8.0),
              Container(
                width: 40.0,
                height: 40.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: AppColors.primaryColor,
                ),
                child: const Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
