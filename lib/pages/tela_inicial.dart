import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(
      home: InicialScreen(),
      debugShowCheckedModeBanner: false,
    ));

class InicialScreen extends StatelessWidget {
  const InicialScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Column(
          children: [
            Container(
                margin: const EdgeInsets.all(15.0),
                padding: const EdgeInsets.all(3.0),
                width: 278,
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xff24c153))),
                child: Stack(
                  children: [
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Buscar",
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      child: Container(
                        width: 28,
                        height: 38,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0xff24c153),
                        ),
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ],
    ));
  }
}
