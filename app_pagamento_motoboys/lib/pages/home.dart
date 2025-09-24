import 'package:app_pagamento_motoboys/wigdets/menuDrawer.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Menudrawer(),
      appBar: AppBar(centerTitle: true, title: Text("Meu App")
    ),
    body: Column(children: [
      Card()
    ],),
    );
  }
}
