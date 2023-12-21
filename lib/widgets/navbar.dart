import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:mobirural/constants/appconstants.dart';
import 'package:mobirural/pages/camera.dart';
import 'package:mobirural/pages/liked.dart';
import 'package:mobirural/pages/navigation.dart';
import 'package:mobirural/pages/perfil.dart';
import 'package:mobirural/pages/tela_inicial.dart';

class HomeNavBar extends StatefulWidget {
  const HomeNavBar({super.key});

  @override
  State<HomeNavBar> createState() => _HomeNavBarState();
}

class _HomeNavBarState extends State<HomeNavBar> {
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  int index = 0;

  // ignore: non_constant_identifier_names
  final Screens = [
    const InicialScreen(),
    const NavigationScreen(),
    const CameraScreen(),
    const LikedScreen(),
    const PerfilScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        body: Screens[index],
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            iconTheme: const IconThemeData(color: AppColors.primaryColor),
          ),
          child: CurvedNavigationBar(
            key: _bottomNavigationKey,
            index: 0,
            height: 60.0,
            items: const <Widget>[
              Icon(CupertinoIcons.building_2_fill,
                  size: 30, semanticLabel: "Início"),
              Icon(Icons.navigation, size: 30, semanticLabel: "Navegação"),
              Icon(CupertinoIcons.camera, size: 30, semanticLabel: "Camera",),
              Icon(Icons.bookmark, size: 30, semanticLabel: "Favoritos"),
              Icon(Icons.person, size: 30, semanticLabel: "Meu Perfil",),
            ],
            color: Colors.white,
            backgroundColor: Colors.transparent,
            buttonBackgroundColor: Colors.white,
            animationCurve: Curves.easeInOut,
            animationDuration: const Duration(milliseconds: 600),
            onTap: (index) => setState(() => this.index = index),
            letIndexChange: (index) => true,
          ),
        ));
  }
}
