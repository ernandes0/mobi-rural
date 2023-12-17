import 'package:flutter/material.dart';
import 'package:mobirural/constants/appconstants.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  @override
  Widget build(BuildContext context) {
    Widget teste = const Center(
      child: Text('Navegação'),
    );
    
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      extendBody: true,
      body: teste,
    );
  }
}
