import 'package:flutter/material.dart';
import 'package:mobirural/constants/appconstants.dart';
import 'package:mobirural/models/building_model.dart';
import 'package:mobirural/models/user_model.dart';
import 'package:mobirural/pages/navigation.dart';
import 'package:mobirural/services/accessibility_info.dart';
import 'package:mobirural/services/distance_calculator.dart';
import 'package:mobirural/services/favorite_service.dart';
import 'package:provider/provider.dart';

class BuildingDetailsScreen extends StatefulWidget {
  final Building building;

  const BuildingDetailsScreen({super.key, required this.building});

  @override
  State<BuildingDetailsScreen> createState() => _BuildingDetailsScreenState();
}

class _BuildingDetailsScreenState extends State<BuildingDetailsScreen> {
  late bool isFavorite = false;
  late String userId;

  @override
  void initState() {
    super.initState();
    checkFavoriteStatus();
  }

  Future<void> checkFavoriteStatus() async {
    final userModel = Provider.of<UserModel>(context, listen: false);
    final userId = userModel.getId();

    bool favoriteStatus = await FavoriteService()
        .isBuildingFavorite(userId ?? '', widget.building.id ?? '');
    setState(() {
      isFavorite = favoriteStatus;
    });
  }

  Future<void> toggleFavorite() async {
    final userModel = Provider.of<UserModel>(context, listen: false);
    final userId = userModel.getId();

    if (isFavorite) {
      await FavoriteService()
          .removeFavoriteBuilding(userId!, widget.building.id!);
    } else {
      await FavoriteService().addFavoriteBuilding(userId!, widget.building.id!);
    }
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    Building building = widget.building;

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
        actions: [
          IconButton(
            onPressed: () {
              toggleFavorite();
            },
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: AppColors.primaryColor,
              size: 50.0,
            ),
          ),
        ],
      ),
    );

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
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: AppColors.textColor),
            textAlign: TextAlign.center,
          );
        } else if (snapshot.hasData) {
          double? distance = snapshot.data;
          return Text(
            '${distance?.toStringAsFixed(2)} Km',
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

    Widget infos = Padding(
        padding: const EdgeInsets.all(16.0),
        child: AccessibilityInfoWidget(
          specialParking: building.parking,
          accessRamps: building.accessRamps,
          elevator: building.elevator,
          adaptedBathroom: building.adaptedBathroom,
          tactilePaving: building.floor,
        ));

    Widget guiar = Padding(
      padding: const EdgeInsets.all(20.0),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const NavigationScreen()));
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              AppColors.primaryColor,
            ),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              const EdgeInsets.symmetric(vertical: 10.0),
            ),
          ),
          child: const Text(
            'Guie-me até o prédio',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
        ),
      ),
    );

    return Scaffold(
      body: ListView(
        children: [
          appbar,
          imagem,
          const SizedBox(height: 5.0),
          predio,
          distancia,
          infos,
          guiar,
        ],
      ),
    );
  }
}
