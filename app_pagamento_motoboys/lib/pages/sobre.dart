import 'dart:io';

import 'package:app_pagamento_motoboys/wigdets/menuDrawer.dart';
import 'package:flutter/material.dart';

class Sobre extends StatelessWidget {
  const Sobre({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Menudrawer(),
      appBar: AppBar(centerTitle: true, title: Text("Meu app")),
      body: Center(
        child: Column(
  children: [
    const Text("203788"),
    const Text("Eduardo dos Santos de Camargo"),
    
    InkWell(
      onTap: () {
        showAboutDialog(
          context: context,
          applicationName: 'Meu App',
          applicationVersion: '1.0.0',
          applicationLegalese: '© 2025 Eduardo dos Santos de Camargo',
        );
      },
      borderRadius: BorderRadius.circular(8),

      child: const Padding(
        padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          
          children: [
            Icon(Icons.info_sharp),
            SizedBox(width: 8),
            Text('Sobre'),
          ],
        ),
      ),
    ),
    ],
)
      ),
    );
  }
}
