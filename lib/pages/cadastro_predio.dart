import 'package:flutter/material.dart';
import 'package:mobirural/constants/appconstants.dart';

class CreateBuilding extends StatefulWidget {
  const CreateBuilding({super.key});

  @override
  State<CreateBuilding> createState() => _CreateBuildingState();
}

class _CreateBuildingState extends State<CreateBuilding> {
  @override
  Widget build(BuildContext context) {
    Widget teste = const Center(
      child: Text('Edição de Predio'),
    );

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      extendBody: true,
      body: teste,
    );
  }
}
