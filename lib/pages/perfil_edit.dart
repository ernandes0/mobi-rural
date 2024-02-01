import 'package:flutter/material.dart';
import 'package:mobirural/constants/appconstants.dart';
import 'package:mobirural/models/user_model.dart';
import 'package:provider/provider.dart';
import 'package:mobirural/widgets/forms.dart';
import 'package:mobirural/widgets/appbar_edit.dart';
import 'package:mobirural/widgets/navbar.dart';

class EditPerfil extends StatefulWidget {
  const EditPerfil({super.key});

  @override
  State<EditPerfil> createState() => _EditPerfilState();
}

class _EditPerfilState extends State<EditPerfil> {
  final Widget _appbaredit = const AppBarEdit(titleName: 'Editar');
  late String _nameController;
  late String _emailController;
  editFormName(context, userModel) {
    _nameController = '${userModel.userData["name"]}';
    return Forms(
      inputLabelName: 'Nome',
      inputText: _nameController,
    );
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final userModel = Provider.of<UserModel>(context);
    if (userModel.isLoading) {
      return const Center(
        child: Scaffold(
          body: Center(
            child: CircularProgressIndicator(
              color: AppColors.accentColor,
            ),
          ),
        ),
      );
    }

    Widget editFormName(BuildContext context, UserModel userModel) {
      _nameController = '${userModel.userData["name"]}';
      return Forms(
        inputLabelName: 'Nome',
        inputText: _nameController,
      );
    }

    Widget editFormEmail(BuildContext context, UserModel userModel) {
      _emailController = '${userModel.userData["email"]}';
      return Forms(
        inputLabelName: 'Email',
        inputText: _emailController,
      );
    }

    Widget formBox = Consumer<UserModel>(
      builder: (context, userModel, child) {
        return Center(
          child: Form(
            key: _formKey,
            child: SizedBox(
              height: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Edite suas informações',
                    style: TextStyle(fontSize: 22),
                  ),
                  editFormName(context, userModel),
                  editFormEmail(context, userModel),
                ],
              ),
            ),
          ),
        );
      },
    );

    Widget saveEdit = SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            Map<String, dynamic> userData = {
              //TODO: Corrigir os campos modificados
              "name": _nameController,
              "email": _emailController,
            };

            userModel.updateProfile(
              userData: userData,
              onSuccess: _onSuccess,
              onFail: _onFail,
            );
          }
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            AppColors.primaryColor,
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            const EdgeInsets.symmetric(vertical: 10.0),
          ),
        ),
        child: const Text(
          'Atualizar Conta',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        extendBody: true,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: _appbaredit,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: [
              const SizedBox(height: 20),
              formBox,
              const SizedBox(height: 20),
              saveEdit,
              const SizedBox(height: 20),
            ],
          ),
        ));
  }

  void _onSuccess() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Usuário atualizado com sucesso!'),
        backgroundColor: AppColors.primaryColor,
        duration: Duration(seconds: 1),
      ),
    );

    Future.delayed(const Duration(seconds: 3)).then((_) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeNavBar(),
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
}
