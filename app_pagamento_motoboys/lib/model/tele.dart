// lib/model/tele.dart

class Tele {
  final String endereco;
  final double valor;

  Tele({required this.endereco, required this.valor});

  Map<String, dynamic> toJson() {
    return {
      'endereco': endereco,
      'valor': valor,
    };
  }

  factory Tele.fromJson(Map<String, dynamic> json) {
    return Tele(
      endereco: json['endereco'] ?? 'Endereço não encontrado',
      valor: (json['valor'] as num?)?.toDouble() ?? 0.0,
    );
  }

  @override
  String toString() {
    return '$endereco - R\$ ${valor.toStringAsFixed(2)}';
  }
}