import 'package:flutter/material.dart';
import 'package:mobirural/constants/appconstants.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  @override
  Widget build(BuildContext context) {
    Widget teste = const Center(
      child: Text('Camera'),
    );
    
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      extendBody: true,
      body: teste,
    );
  }
}
