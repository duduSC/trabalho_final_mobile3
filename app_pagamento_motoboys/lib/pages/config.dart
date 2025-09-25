import 'package:app_pagamento_motoboys/main.dart';
import 'package:app_pagamento_motoboys/wigdets/menuDrawer.dart';
import 'package:flutter/material.dart';

class Config extends StatelessWidget {
  const Config({super.key});

  @override
  Widget build(BuildContext context) {
    // Adicionando o Scaffold com o drawer para manter a consistência do app
    return Scaffold(
      drawer: const Menudrawer(),
      appBar: AppBar(
        centerTitle: true,
        // Título mais apropriado para a tela
        title: const Text('Configurações'),
      ),
      // Usando um ListView para organizar as opções.
      // Fica mais fácil adicionar novas configurações no futuro.
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: [
          // ValueListenableBuilder agora constrói um ListTile,
          // que é o padrão para itens em uma tela de configurações.
          ValueListenableBuilder<ThemeMode>(
            valueListenable: temaService.temaNotifier,
            builder: (context, currentMode, child) {
              final isDarkMode = currentMode == ThemeMode.dark;
              return ListTile(
                leading: Icon(
                  isDarkMode ? Icons.dark_mode_outlined : Icons.light_mode_outlined,
                ),
                title: const Text('Modo Escuro'),
                subtitle: Text(
                  isDarkMode ? 'Ativado' : 'Desativado',
                ),
                // O Switch agora fica no final do ListTile, que é a posição esperada.
                trailing: Switch.adaptive(
                  value: isDarkMode,
                  onChanged: (value) {
                    temaService.toggleTema();
                  },
                ),
                onTap: () {
                  // Permite que o usuário clique na linha inteira para mudar o tema
                  temaService.toggleTema();
                },
              );
            },
          ),
          const Divider(),
          // Você pode adicionar outras configurações aqui no futuro
          // ListTile(
          //   leading: const Icon(Icons.notifications_outlined),
          //   title: const Text('Notificações'),
          //   trailing: Switch.adaptive(value: true, onChanged: (val){}),
          // ),
        ],
      ),
    );
  }
}