import 'package:flutter/material.dart';
import 'package:mobirural/constants/appconstants.dart';

class LikedScreen extends StatefulWidget {
  const LikedScreen({super.key});

  @override
  State<LikedScreen> createState() => _LikedScreenState();
}

class _LikedScreenState extends State<LikedScreen> {
  @override
  Widget build(BuildContext context) {
    Widget teste = const Center(
      child: Text('Favoritos'),
    );
    
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      extendBody: true,
      body: teste,
    );
  }
}
