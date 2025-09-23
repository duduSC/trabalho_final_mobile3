class User {
  String? id;
  String? usuario;
  String? senha;


  User({
    this.id,
    this.usuario,
    this.senha
  });

  Map<String,dynamic> toJson(){
    return {
      "id" : id,
      "usuario": usuario,
      "senha": senha
    };
  }
  factory User.fromJson(
      Map<String,dynamic> json
      ){
    return User(
      id: json['id']?.toString(),
      usuario: json['usuario'] ?? "",
      senha: json['senha'] ?? ""
    );
  }
}