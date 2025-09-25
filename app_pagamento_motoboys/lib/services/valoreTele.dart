class Valoretele {
  final int ateKm; // O limite da faixa (ex: 5.0 para "até 5 km")
  final double valor; // O valor a ser cobrado nesta faixa (ex: 10.0 para "R$ 10,00")

  const Valoretele({required this.ateKm, required this.valor});
}