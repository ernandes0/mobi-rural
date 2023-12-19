import 'package:flutter/material.dart';

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