import 'package:app_pagamento_motoboys/router.dart';
import 'package:app_pagamento_motoboys/wigdets/cards.dart';
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
      appBar: AppBar(centerTitle: true, title: Text("Meu App")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           CardNavegacao(
              icone: Icons.motorcycle,
              titulo: "Motoboys",
              paginaDestino: Routes.motoboys,
            ),
            const SizedBox(width: 24),
            CardNavegacao(
              icone: Icons.pages,
              titulo: "Teles",
              paginaDestino: Routes.teles,
            ),
          ],
        ),
      ),
    );
  }
}
