import 'package:app_pagamento_motoboys/model/motoboy.dart';
import 'package:app_pagamento_motoboys/model/tele.dart'; // Importe o novo modelo
import 'package:app_pagamento_motoboys/services/mapsService.dart';
import 'package:app_pagamento_motoboys/services/motoboyService.dart';
import 'package:app_pagamento_motoboys/services/tabelaPreco.dart';
import 'package:app_pagamento_motoboys/wigdets/menuDrawer.dart';
import 'package:flutter/material.dart';

class GerenciamentoTelesPage extends StatefulWidget {
  final MotoboyService service;
  const GerenciamentoTelesPage({super.key, required this.service});

  @override
  State<GerenciamentoTelesPage> createState() => _GerenciamentoTelesPageState();
}

class _GerenciamentoTelesPageState extends State<GerenciamentoTelesPage> {
  late Future<List<Motoboy>> _futureMotoboys;
  final Map<String, TextEditingController> _controllers = {};

  // Crie instâncias dos serviços que vamos precisar
  final _mapsService = MapsService();
  final _tabelaPrecosService = Tabelapreco();

  final String _enderecoOrigem = "-28.232667,-52.381083"; 

  @override
  void initState() {
    super.initState();
    _reload();
  }

  void _reload() {
    setState(() {
      _futureMotoboys = widget.service.getMotoboys();
    });
  }

  Future<void> _adicionarTele(String motoboyId, String enderecoDestino) async {
    if (enderecoDestino.isEmpty) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      final double distanciaKm = await _mapsService.getDistance(_enderecoOrigem.trim(), enderecoDestino.trim());

      final double valor = _tabelaPrecosService.calcularValorDaTele(distanciaKm);

      final novaTele = Tele(endereco: enderecoDestino, valor: valor);
      final tele_final = novaTele.toString(); 

      await widget.service.createTele(
        idMotoboy: motoboyId,
        novaTele: tele_final, 
      );
      
      Navigator.pop(context); // Fecha o indicador de carregamento

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Tele adicionada com sucesso!"), backgroundColor: Colors.green),
      );
      
      _controllers[motoboyId]?.clear();
      _reload();

    } catch (e) {
      Navigator.pop(context); // Fecha o indicador de carregamento
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro ao adicionar: $e"), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // O resto do seu build continua igual...
    return Scaffold(
      drawer: const Menudrawer(),
      appBar: AppBar(
        title: const Text("Gerenciar Teles"),
      ),
      body: FutureBuilder<List<Motoboy>>(
        future: _futureMotoboys,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Erro ao carregar motoboys: ${snapshot.error}"));
          }
          final motoboys = snapshot.data ?? [];
          if (motoboys.isEmpty) {
            return const Center(child: Text("Nenhum motoboy encontrado."));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: motoboys.length,
            itemBuilder: (context, index) {
              final motoboy = motoboys[index];
              _controllers.putIfAbsent(motoboy.id!, () => TextEditingController());
              return _buildMotoboyExpansionTile(motoboy);
            },
          );
        },
      ),
    );
  }

  Widget _buildMotoboyExpansionTile(Motoboy motoboy) {
    final initials = motoboy.nome.isNotEmpty
        ? motoboy.nome.trim().split(' ').map((l) => l[0]).take(2).join().toUpperCase()
        : '';
    final teles = motoboy.teles ?? [];

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.antiAlias,
      child: ExpansionTile(
        leading: CircleAvatar(
          child: Text(initials),
        ),
        title: Text(motoboy.nome, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text("${teles.length} tele(s) registrada(s)"),
        children: [
          ...teles.map((tele) => ListTile(
                leading: const Icon(Icons.location_on_outlined, color: Colors.grey),
                title: Text(tele), 
                dense: true,
              )),
          const Divider(height: 1, indent: 16, endIndent: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controllers[motoboy.id!],
                    decoration: const InputDecoration(
                      labelText: "Endereço final da tele",
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton.filled(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    final enderecoFinal = _controllers[motoboy.id!]!.text;
                    _adicionarTele(motoboy.id!, enderecoFinal);
                  },
                  tooltip: 'Adicionar e Calcular',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}