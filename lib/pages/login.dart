import 'package:flutter/material.dart';
import 'package:mobirural/constants/appconstants.dart';
import 'package:mobirural/models/user_model.dart';
import 'package:mobirural/pages/cadastro.dart';
import 'package:mobirural/pages/tela_inicial.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final userModel = Provider.of<UserModel>(context);

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: userModel.isLoading
                ? const CircularProgressIndicator(
                    color: AppColors.accentColor,
                  )
                : Form(
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
                        TextFormField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            labelStyle: TextStyle(color: Colors.grey),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.primaryColor,
                              ),
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
                          controller: _passController,
                          decoration: const InputDecoration(
                            labelText: 'Senha',
                            labelStyle: TextStyle(color: Colors.grey),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ),
                          obscureText: true,
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.length < 6) {
                              return 'A senha deve ter no mínimo 6 caracteres';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            TextButton(
                              onPressed: () {
                                // Implementar ação para "Esqueci a senha"
                              },
                              child: const Text(
                                'Esqueci a senha',
                                style:
                                    TextStyle(color: AppColors.primaryColor),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 40.0),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                userModel.signIn(
                                  email: _emailController.text,
                                  pass: _passController.text,
                                  onSuccess: _onSuccess,
                                  onFail: _onFail,
                                );
                              }
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                AppColors.primaryColor,
                              ),
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
                              'Entrar',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
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
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const CadastroScreen(),
                                  ),
                                );
                              },
                              child: const Text(
                                'Crie um cadastro',
                                style: TextStyle(
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  void _onSuccess() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const InicialScreen(),
      ),
    );
  }

  void _onFail() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Falha ao entrar'),
        backgroundColor: Color.fromARGB(255, 222, 22, 22),
        duration: Duration(seconds: 1),
      ),
    );
  }
}
