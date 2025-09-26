import 'package:app_pagamento_motoboys/main.dart';
import 'package:app_pagamento_motoboys/provider/userProvider.dart';
import 'package:app_pagamento_motoboys/wigdets/menuDrawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Config extends StatelessWidget {
  const Config({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Userprovider>(context).user;
    return Scaffold(
      drawer: const Menudrawer(),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Configurações'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: [
          ValueListenableBuilder<ThemeMode>(
            valueListenable: temaService.temaNotifier,
            builder: (context, currentMode, child) {
              final isDarkMode = currentMode == ThemeMode.dark;
              return ListTile(
                leading: Icon(
                  isDarkMode
                      ? Icons.dark_mode_outlined
                      : Icons.light_mode_outlined,
                ),
                title: const Text('Modo Escuro'),
                subtitle: Text(isDarkMode ? 'Ativado' : 'Desativado'),
                trailing: Switch.adaptive(
                  value: isDarkMode,
                  onChanged: (value) {
                    temaService.toggleTema();
                  },
                ),
                onTap: () {
                  temaService.toggleTema();
                },
              );
            },
          ),
          const Divider(),
          Text(user!.nome),
          Text(user.senha),
        ],
      ),
    );
  }
}
