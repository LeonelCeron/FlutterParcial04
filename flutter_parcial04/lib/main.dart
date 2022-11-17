
import 'package:flutter_parcial04/Clientes.dart';
import 'package:flutter_parcial04/Principal.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'package:flutter_parcial04/Pantallas/Principal.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Parcial04());
}

class Parcial04 extends StatelessWidget {
  const Parcial04({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Firebase Firestore',
      home: Clientes(),
    );
  }
}
