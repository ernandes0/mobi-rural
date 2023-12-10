import 'package:flutter/material.dart';
import 'package:mobirural/models/user_model.dart';
import 'package:mobirural/pages/tela_inicial.dart';
import 'package:scoped_model/scoped_model.dart';

void main() => runApp(
      const MaterialApp(
        home: CadastroScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );

class CadastroScreen extends StatefulWidget {
  const CadastroScreen({super.key});

  @override

  // ignore: library_private_types_in_public_api
  _CadastroScreenState createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  final _namecontroller = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final passwordController = TextEditingController();
    bool isPasswordValid = true;
    bool isPasswordConfirmed = true;

    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: Colors.greenAccent[700],
            onPressed: () {
              Navigator.of(context).pop(); // Ação para voltar
            },
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: ScopedModelDescendant<UserModel>(
                    builder: (context, child, model) {
                  if (model.isLoading) {
                    return const Center(
                      child:
                          CircularProgressIndicator(color: Color.fromARGB(255, 0, 200, 83)),
                    );
                  }
                  return Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          width: 100,
                          height: 108,
                          child: Image.asset('assets/logo.png'),
                        ),
                        const Text(
                          'Cadastre-se',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextFormField(
                          controller: _namecontroller,
                          decoration: const InputDecoration(
                            labelText: 'Nome',
                            labelStyle: TextStyle(color: Colors.grey),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 0, 200, 83)),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Digite seu nome';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10.0),
                        TextFormField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            labelStyle: TextStyle(color: Colors.grey),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 0, 200, 83)),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || !value.contains('@')) {
                              return 'Digite um email válido';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10.0),
                        TextFormField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            labelText: 'Senha',
                            labelStyle: TextStyle(color: Colors.grey),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 0, 200, 83)),
                            ),
                          ),
                          onChanged: (value) {
                            if (value.length >= 6 &&
                                RegExp(r'(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$%^&*()\/_+]).{6,}')
                                    .hasMatch(value)) {
                              isPasswordValid = true;
                            } else {
                              isPasswordValid = false;
                            }
                            // Rebuild the widget to show/hide the error icon
                            // You can't call setState inside a StatelessWidget
                          },
                          validator: (value) {
                            if (!isPasswordValid) {
                              return 'A senha deve ter 6 caracteres, letras maiúsculas, minúsculas, números e caracteres especiais';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10.0),
                        TextFormField(
                          controller: _passController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            labelText: 'Confirmar Senha',
                            labelStyle: TextStyle(color: Colors.grey),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 0, 200, 83)),
                            ),
                          ),
                          onChanged: (value) {
                            if (value == passwordController.text) {
                              isPasswordConfirmed = true;
                            } else {
                              isPasswordConfirmed = false;
                            }
                            // Rebuild the widget to show/hide the error icon
                            // You can't call setState inside a StatelessWidget
                          },
                          validator: (value) {
                            if (!isPasswordConfirmed) {
                              return 'As senhas não coincidem';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 40.0),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                Map<String, dynamic> userData = {
                                  "name": _namecontroller.text,
                                  "email": _emailController.text,
                                };

                                model.signUp(
                                    userData: userData,
                                    pass: _passController.text,
                                    onSuccess: _onSuccess,
                                    onFail: _onFail,
                                    onEmailAlreadyInUse: _onEmailAlreadyInUse);
                                // Implementar ação para "Criar Conta"
                              }
                            },
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.greenAccent[700]),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                              ),
                              padding:
                                  MaterialStateProperty.all<EdgeInsetsGeometry>(
                                const EdgeInsets.symmetric(vertical: 10.0),
                              ),
                            ),
                            child: const Text(
                              'Criar Conta',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                })),
          ),
        ));
  }

  void _onSuccess() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Usuário criado com sucesso!'),
        backgroundColor: Color.fromARGB(255, 105, 240, 141),
        duration: Duration(seconds: 1),
      ),
    );

    Future.delayed(const Duration(seconds: 1)).then((_) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const InicialScreen(),
        ),
      );
    });
  }

  void _onFail() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Falha na criação do usuário!'),
        backgroundColor: Color.fromARGB(255, 222, 22, 22),
        duration: Duration(seconds: 1),
      ),
    );
  }

  void _onEmailAlreadyInUse() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('O e-mail já está em uso por outra conta.'),
        backgroundColor: Colors.red,
      ),
    );
  }
}
