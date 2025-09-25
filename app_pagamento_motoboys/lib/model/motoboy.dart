class Motoboy {
  String? id;
  String nome;
  String cpf;
  String telefone;
  List<String>? teles;

  Motoboy({
    this.id,
    required this.nome,
    required this.cpf,
    required this.telefone,
    this.teles,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "nome": nome,
      "cpf": cpf,
      "telefone": telefone,
      "teles": teles,
    };
  }

  Map<String, dynamic> toJsonEdit() {
    return {"id": id, "nome": nome, "cpf": cpf, "telefone": telefone};
  }

  Map<String, dynamic> toJsonTele() {
    return {"teles": teles};
  }

  factory Motoboy.fromJson(Map<String, dynamic> json) {
    return Motoboy(
      id: json['id']?.toString(),
      nome: json['nome'] ?? "",
      cpf: json['cpf'] ?? "",
      telefone: json['telefone'] ?? "",
      teles: json['teles'] != null ? List<String>.from(json["teles"]) : [],
    );
  }
}
