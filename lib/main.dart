import 'package:teste/pages/login.dart';
import 'package:flutter/material.dart';

void main() => runApp(const Home());

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'MobiRural',
      home: LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}