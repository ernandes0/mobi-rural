import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mobirural/config/firebase_options.dart';
import 'package:mobirural/models/user_model.dart';
import 'package:mobirural/widgets/user_state.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserModel()),
      ],
      child: const App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Mobirural',
      home: InitScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}