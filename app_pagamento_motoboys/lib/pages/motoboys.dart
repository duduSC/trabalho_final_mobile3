import 'package:app_pagamento_motoboys/model/motoboy.dart';
import 'package:app_pagamento_motoboys/pages/forms/motoboysForm.dart';
import 'package:app_pagamento_motoboys/router.dart';
import 'package:app_pagamento_motoboys/services/motoboyService.dart';
import 'package:app_pagamento_motoboys/wigdets/menuDrawer.dart';
import 'package:flutter/material.dart';

class Motoboys extends StatefulWidget {
  final MotoboyService service;
  const Motoboys({super.key, required this.service});

  @override
  State<Motoboys> createState() => _MotoboysState();
}

class _MotoboysState extends State<Motoboys> {
  late Future<List<Motoboy>> _future;

  @override
  void initState() {
    super.initState();
    _reload();
  }

  void _reload() {
    setState(() {
      _future = widget.service.getMotoboys();
    });
  }

  Future<void> _goToEdit(Motoboy m) async {
    final changed = await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (_) => Motoboysform(service: widget.service, initial: m),
      ),
    );
    if (changed == true) _reload();
  }

  
  Widget _motoboyCard(Motoboy m) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => _goToEdit(m),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: ListTile(
                  title: Text(
                    m.nome,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              Icon(Icons.arrow_forward)
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Motoboys')),
      drawer: const Menudrawer(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () =>
            Navigator.pushNamed(context, Routes.motoboyForm).then((changed) {
              if (changed == true) _reload();
            }),
        icon: const Icon(Icons.person_add_alt_1),
        label: const Text('Novo'),
      ),
      body: RefreshIndicator(
        onRefresh: () async => _reload(),
        child: FutureBuilder<List<Motoboy>>(
          future: _future,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return ListView(
                children: [
                  const SizedBox(height: 120),
                  Center(
                    child: Column(
                      children: [
                        const Icon(Icons.error_outline, size: 48),
                        const SizedBox(height: 8),
                        Text('Erro ao carregar: ${snapshot.error}'),
                        const SizedBox(height: 8),
                        FilledButton.icon(
                          onPressed: _reload,
                          icon: const Icon(Icons.refresh),
                          label: const Text('Tentar novamente'),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
            final users = snapshot.data ?? [];
            if (users.isEmpty) {
              return ListView(
                children: const [
                  SizedBox(height: 120),
                  Center(child: Text('Nenhum motoboy encontrado')),
                ],
              );
            }
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (_, i) => _motoboyCard(users[i]),
            );
          },
        ),
      ),
    );
  }
}
