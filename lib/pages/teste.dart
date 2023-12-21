import 'package:flutter/material.dart';
import 'package:mobirural/models/building_model.dart';
import 'package:mobirural/services/building_service.dart';
import 'package:provider/provider.dart';

class TestePage extends StatelessWidget {
  const TestePage({super.key});

  @override
  Widget build(BuildContext context) {
    final buildingService = Provider.of<BuildingService>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('TESTE'),
      ),
      body: FutureBuilder<List<Building>>(
        future: buildingService.getBuildings(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Erro ao carregar os dados dos edifícios'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('Nenhum edifício encontrado'),
            );
          } else {
            List<Building> buildings = snapshot.data!;

            return ListView.builder(
              itemCount: buildings.length,
              itemBuilder: (context, index) {
                Building building = buildings[index];
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    
                    title: Text(building.name ?? 'Nome do edifício não disponível'),
                    subtitle: Text(building.floor ?? 'Piso não disponível'),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
