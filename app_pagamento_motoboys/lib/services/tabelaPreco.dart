import 'package:app_pagamento_motoboys/services/valoreTele.dart';

class Tabelapreco {
  final List<Valoretele> _tabela = [
    const Valoretele(ateKm: 2, valor: 9),

    const Valoretele(ateKm: 4, valor: 12),

    const Valoretele(ateKm: 6, valor: 15),

    const Valoretele(ateKm: 10, valor: 18),

    const Valoretele(ateKm: 20, valor: 30),
  ];
  double calcularValorDaTele(double distanciaKm) {
    if (distanciaKm <= 0) {
      return 0.0;
    }

    // Procura na tabela a primeira faixa que cobre a distância
    for (final faixa in _tabela) {
      if (distanciaKm <= faixa.ateKm) {
        return faixa.valor;
      }
    }

    return 40;
  }
}
