import 'package:app_pagamento_motoboys/services/temaService.dart';
import 'package:app_pagamento_motoboys/wigdets/menuDrawer.dart';
import 'package:flutter/material.dart';
import 'package:app_pagamento_motoboys/main.dart';

class Config extends StatelessWidget {
  const Config({super.key});


 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tema com SharedPreferences'),
        actions: [
          // ValueListenableBuilder é útil aqui também para reconstruir apenas o ícone/switch
          ValueListenableBuilder<ThemeMode>(
            valueListenable: temaService.temaNotifier,
            builder: (context, currentMode, child) {
              return Switch.adaptive(
                // O valor do switch é baseado no estado atual do notifier
                value: currentMode == ThemeMode.dark,
                // Ao clicar, chamamos o método toggleTheme do nosso serviço
                onChanged: (value) {
                  temaService.toggleTema();
                },
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'O tema foi salvo!',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 10),
            const Text('Feche e reabra o aplicativo.'),
          ],
        ),
      ),
    );
  }
}
