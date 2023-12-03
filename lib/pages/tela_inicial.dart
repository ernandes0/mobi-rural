import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(const MaterialApp(
      home: InicialScreen(),
      debugShowCheckedModeBanner: false,
    ));

class InicialScreen extends StatefulWidget {
  const InicialScreen({Key? key}) : super(key: key);

  @override
  State<InicialScreen> createState() => _InicialScreenState();
}

class _InicialScreenState extends State<InicialScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky,
        overlays: [
          SystemUiOverlay.top,
        ]);
  }

  @override
  Widget build(BuildContext context) {
    Widget barradebusca = Container(
      margin: const EdgeInsets.all(20.0),
      width: 278,
      height: 40,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xff24c153))),
      child: Stack(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Buscar',
              ),
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            child: Container(
              width: 28,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xff24c153),
              ),
              child: const Icon(Icons.mic, size: 20, color: Colors.white),
            ),
          ),
        ],
      ),
    );

    Widget boasvindas = const Center(
      child: SizedBox(
        height: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Olá, João!',
              style: TextStyle(fontSize: 22),
            ),
            SizedBox(height: 12),
            Text(
              'Estes são os prédios disponíveis:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );

    Widget colunadupla = SizedBox(
      height: MediaQuery.of(context).size.height - 268,
      child: GridView.builder(
        itemCount: 20,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1 / 1,
          crossAxisSpacing: 2,
          mainAxisSpacing: 1,
        ),
        itemBuilder: (BuildContext context, int index) {
          return Card(
            semanticContainer: true,
            margin: const EdgeInsets.all(15),
            child: Center(
              child: Text('Item $index'),
            ),
          );
        },
      ),
    );

    Widget botaoCamera = FloatingActionButton(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(50.0)),
      ),
      onPressed: () {},
      elevation: 5,
      backgroundColor: Colors.green,
      child: Image.asset('assets/cam_icon.png'),
      // TODO: Ajustar posição do botão com teclado
    );

    return Scaffold(
      body: ListView(
        children: [
          barradebusca,
          boasvindas,
          colunadupla,
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(null), // Ícone invisível para espaçamento
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.navigation),
            label: 'Navegador',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Salvos',
            backgroundColor: Colors.purple,
          ),
        ],
      ),
      floatingActionButton: botaoCamera,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
