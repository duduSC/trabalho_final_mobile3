class Motoboy{
  String? id;
  String? nome;
  String? cpf;
  List<String>? teles;


  Motoboy({
    this.id,
    this.nome,
    this.cpf,
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
  factory Motoboy.fromJson(
      Map<String,dynamic> json
      ){
    return Motoboy(
        id: json['id']?.toString(),
        nome: json['nome'] ?? "",
        cpf: json['cpf'] ?? "",
        teles: json['teles']?? []
    );
  }
}