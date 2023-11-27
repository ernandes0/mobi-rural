import 'package:flutter/material.dart';
import 'cadastro.dart';

void main() => runApp(const MaterialApp(
      home: LoginScreen(),
      debugShowCheckedModeBanner: false,
    ));

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                  width: 100,
                  height: 108,
                  child: Image.asset('assets/logo.png'),
                ),  
              const Text(
                'MobiRural',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20.0),
              const Text(
                'Faça login na sua conta',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(height: 40.0),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: const TextStyle(color: Colors.grey),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.greenAccent.shade700),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Senha',
                  labelStyle: const TextStyle(color: Colors.grey),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.greenAccent.shade700),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  TextButton(
                    onPressed: () {
                      // Implementar ação para "Esqueci a senha"
                    },
                    child: Text('Esqueci a senha', style: TextStyle(color: Colors.greenAccent[700])),
                  ),
                ],
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Implementar ação para "Entrar"
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.greenAccent[700]),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0), // Ajuste o valor para arredondar mais ou menos
                      ),
                    ),
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      const EdgeInsets.symmetric(vertical: 10.0), // Ajuste o tamanho do botão aqui
                    ),
                  ),
                  child: const Text('Entrar', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Ainda não é usuário? ',
                    style: TextStyle(color: Colors.black),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const CadastroScreen()));
                    },
                    child: Text('Crie um cadastro', style: TextStyle(color: Colors.greenAccent[700])),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}