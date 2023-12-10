import 'package:firebase_core/firebase_core.dart';
import 'package:mobirural/firebase_options.dart';
import 'package:mobirural/models/user_model.dart';
import 'package:mobirural/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const Home());
}


class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
      model: UserModel(),
      child: const MaterialApp(
        title: 'MobiRural',
        home: LoginScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
