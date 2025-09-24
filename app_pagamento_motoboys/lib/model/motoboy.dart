class Motoboy{
  String? id;
  String nome;
  String cpf;
  List<String>? teles;


  Motoboy({
    this.id,
    required this.nome,
    required this.cpf,
    this.teles
  });

  Map<String,dynamic> toJson(){
    return {
      "id" : id,
      "nome": nome,
      "cpf": cpf,
      "teles": teles
    };
  }
    Map<String,dynamic> toJsonEdit(){
    return {
      "id" : id,
      "nome": nome,
      "cpf": cpf,
    };
  }
  factory Motoboy.fromJson(
      Map<String,dynamic> json
      ){
    return Motoboy(
        id: json['id']?.toString(),
        nome: json['nome'] ?? "",
        cpf: json['cpf'] ?? "",
        teles: json['teles'] != null ? List<String>.from(json["teles"]): []
    );
  }
}