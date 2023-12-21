import 'package:mobirural/constants/appconstants.dart';
import 'package:mobirural/pages/login.dart';
import 'package:mobirural/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:mobirural/widgets/navbar.dart';
import 'package:provider/provider.dart';

class InitScreen extends StatefulWidget {
  const InitScreen({super.key});

  @override
  State<InitScreen> createState() => _InitScreenState();
}

class _InitScreenState extends State<InitScreen> {
  @override
  Widget build(BuildContext context) {
    UserModel auth = Provider.of<UserModel>(context);

    if (auth.isLoading) {
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

    if (auth.firebaseUser == null) {
      return const LoginScreen();
    }
    return const HomeNavBar();
  }
}
