class User {
  final String? id;
  String nome;
  String senha;


  User({
    this.id,
    required this.nome,
    required this.senha
  });

  Map<String,dynamic> toJson(){
    return {
      "id" : id,
      "nome": nome,
      "senha": senha
    };
  }
  factory User.fromJson(
      Map<String,dynamic> json
      ){
    return User(
      id: json['id']?.toString(),
      nome: json['nome']?? "",
      senha: json['senha'] ?? ""
    );
  }
}