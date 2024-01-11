import 'package:flutter/material.dart';
import 'package:mobirural/constants/appconstants.dart';
import 'package:mobirural/models/building_model.dart';
import 'package:mobirural/models/user_model.dart';
import 'package:mobirural/services/favorite_service.dart';
import 'package:mobirural/widgets/favoritecard.dart';
import 'package:provider/provider.dart';

class LikedScreen extends StatefulWidget {
  const LikedScreen({super.key});

  @override
  State<LikedScreen> createState() => _LikedScreenState();
}

class _LikedScreenState extends State<LikedScreen> {
  final FavoriteService _favoriteService = FavoriteService();
  List<Building> _favoriteBuildings = [];

  @override
  void initState() {
    super.initState();
    _loadFavoriteBuildings();
  }

  Future<void> _loadFavoriteBuildings() async {
    final userModel = Provider.of<UserModel>(context, listen: false);
    final String? userId = userModel.getId();
    try {
      List<Building> favoriteBuildings =
          await _favoriteService.getFavoriteBuildings(userId!);

      setState(() {
        _favoriteBuildings = favoriteBuildings;
      });
    } catch (e) {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget appbar = AppBar(
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      elevation: 0.0,
      title: const Text(
        'Favoritos',
        style: TextStyle(
          color: AppColors.primaryColor,
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
    );

    Widget favoritos = Container(
      margin: const EdgeInsets.only(top: 16.0),
      child: Column(
        children: [
          for (Building building in _favoriteBuildings)
            FavoriteBuildingCard(building: building),
        ],
      ),
    );

    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: ListView(
          children: [
            appbar,
            favoritos,
          ],
        ));
  }
}
