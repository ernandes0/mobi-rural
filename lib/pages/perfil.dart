import 'package:flutter/material.dart';

class PerfilPage extends StatelessWidget {
  final String nome;
  final String email;

  const PerfilPage({super.key, required this.nome, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Nome: $nome'),
            Text('Email: $email'),
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
