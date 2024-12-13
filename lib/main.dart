import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:prueba_02/screens/comentarios_Screen.dart';

import 'package:prueba_02/screens/listaseries_Screen.dart';
import 'package:prueba_02/screens/login_Screen.dart';
import 'package:prueba_02/screens/registro_Screen.dart';
import 'package:prueba_02/screens/welcome_Screen.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);  
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Cuerpo(
      
      ),
    );
  }
}

class Cuerpo extends StatelessWidget {
  const Cuerpo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cuerpo'),
      ),
      body: Welcome(),
    );
  }
}
