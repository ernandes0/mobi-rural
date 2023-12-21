import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobirural/constants/appconstants.dart';
import 'package:mobirural/models/building_model.dart';
import 'package:mobirural/models/user_model.dart';
import 'package:mobirural/services/building_service.dart';
import 'package:mobirural/widgets/buildingcard.dart';
import 'package:provider/provider.dart';

class InicialScreen extends StatefulWidget {
  const InicialScreen({super.key});

  @override
  State<InicialScreen> createState() => _InicialScreenState();
}

class _InicialScreenState extends State<InicialScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky,
        overlays: [
          SystemUiOverlay.top,
        ]);
  }

  @override
  Widget build(BuildContext context) {
    Widget barradebusca = Container(
      margin: const EdgeInsets.all(20.0),
      width: 278,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.primaryColor),
      ),
      child: Stack(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Buscar',
              ),
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            child: Container(
              width: 28,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.primaryColor,
              ),
              child: const Icon(Icons.mic, size: 20, color: Colors.white),
            ),
          ),
        ],
      ),
    );

    Widget boasvindas = Consumer<UserModel>(
      builder: (context, userModel, child) {
        return Center(
          child: SizedBox(
            height: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Olá, ${!userModel.isLoggedIn() ? "" : userModel.userData["name"]}',
                  style: const TextStyle(fontSize: 22),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Estes são os prédios disponíveis:',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        );
      },
    );

    final buildingService =
        Provider.of<BuildingService>(context, listen: false);

    Widget colunadupla = FutureBuilder<List<Building>>(
      future: buildingService.getBuildings(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.primaryColor,
            ),
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('Erro ao carregar os dados dos prédios'),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text('Nenhum prédio encontrado'),
          );
        } else {
          //snapshot.data contém a lista de prédios recuperados
          List<Building> buildings = snapshot.data!;

          return SizedBox(
            height: MediaQuery.of(context).size.height - 268,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1 / 1.25,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 4.0,
              ),
              itemCount: buildings.length,
              itemBuilder: (context, index) {
                return BuildingCard(building: buildings[index]);
              },
            ),
          );
        }
      },
    );

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: ListView(
        children: [
          barradebusca,
          boasvindas,
          colunadupla,
        ],
      ),
    );
  }
}
