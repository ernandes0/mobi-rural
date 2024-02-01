import 'package:flutter/material.dart';
import 'package:mobirural/constants/appconstants.dart';
import 'package:mobirural/widgets/appbar_edit.dart';

class CreateBuilding extends StatefulWidget {
  const CreateBuilding({super.key});

  @override
  State<CreateBuilding> createState() => _CreateBuildingState();
}

class _CreateBuildingState extends State<CreateBuilding> {
  final Widget _appbaredit = const AppBarEdit(titleName: 'Cadastrar prédio');
  @override
  Widget build(BuildContext context) {
    Widget teste = const Center(
      child: Text('Edição de Predio'),
    );

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      extendBody: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: _appbaredit,
      ),
      body: teste,
    );
  }
}
