import 'package:flutter/material.dart';
import 'package:mobirural/constants/appconstants.dart';
import 'package:mobirural/models/building_model.dart';
import 'package:mobirural/services/distance_calculator.dart';

class BuildingDetailsScreen extends StatelessWidget {
  final Building building;

  const BuildingDetailsScreen({super.key, required this.building});

  @override
  Widget build(BuildContext context) {
    Widget appbar = PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          elevation: 0.0,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Container(
              width: 50.0,
              height: 50.0,
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: const Center(
                child: Icon(
                  Icons.chevron_left,
                  color: Colors.white,
                  size: 40.0,
                ),
              ),
            ),
          ),
        ));

    Widget imagem = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          height: 200,
          child: Stack(
            alignment: Alignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(40.0),
                child: Image.network(
                  building.image ?? '',
                  fit: BoxFit.cover,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    } else {
                      return const CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );

    Widget predio = Text(
      building.name ?? '',
      style: const TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    );

    Widget distancia = FutureBuilder<double?>(
      future: calculateDistanceToBuilding(building),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text(
            'Calculando distância...',
            style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor),
            textAlign: TextAlign.center,
          );
        } else if (snapshot.hasError) {
          return Text(
            'Erro ao calcular distância: ${snapshot.error}',
            style: const TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor),
            textAlign: TextAlign.center,
          );
        } else if (snapshot.hasData) {
          double? distance = snapshot.data;
          return Text(
            '${distance?.toStringAsFixed(2)} Km', // Exibindo a distância com duas casas decimais
            style: const TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor),
            textAlign: TextAlign.center,
          );
        } else {
          return const Text('Distância indisponível',
              style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor),
              textAlign: TextAlign.center);
        }
      },
    );

    return Scaffold(
      body: ListView(
        children: [
          appbar,
          imagem,
          predio,
          distancia,
        ],
      ),
    );
  }
}
