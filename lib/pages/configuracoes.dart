import 'package:flutter/material.dart';
import 'package:mobirural/pages/teste.dart';

class ConfiguracoesPage extends StatelessWidget {
  

  const ConfiguracoesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurações'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [            
            TextButton(
              child: const Text('Configurações de acessibilidade'),
              onPressed: (){
              }),
            TextButton(
              child: const Text('Reportar Problema'),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const TestePage()));
              }),
            TextButton(
              child: const Text('Logout'),
              onPressed: (){
              }),
            TextButton(
              child: const Text('Sair'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}