import 'package:app_pagamento_motoboys/router.dart';
import 'package:flutter/material.dart';

class Menudrawer extends StatelessWidget {
  const Menudrawer({super.key});

  void _go(BuildContext context, String route) {
    final current = ModalRoute.of(context)?.settings.name;
    if (current == route) {
      Navigator.pop(context);
      return;
    }
    Navigator.pushReplacementNamed(context, route);
  }

  void _logoff(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      Routes.login,
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final current = ModalRoute.of(context)?.settings.name;

    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            Container(
              height: 100,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Meu App',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.red.shade100,
                    child: IconButton(
                      icon: const Icon(Icons.logout, color: Colors.red),
                      onPressed: () => _logoff(context),
                      tooltip: 'Sair',
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    leading: const Icon(Icons.home),
                    title: const Text('Início'),
                    selected: current == Routes.home,
                    onTap: () => _go(context, Routes.home),
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: const Text('Configuração'),
                    selected: current == Routes.config,
                    onTap: () => _go(context, Routes.config),
                  ),
                   ListTile(
                    leading: const Icon(Icons.info),
                    title: const Text('Sobre'),
                    selected: current == Routes.sobre,
                    onTap: () => _go(context, Routes.sobre),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
