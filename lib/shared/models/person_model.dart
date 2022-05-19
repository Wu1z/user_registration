class PersonModel {
  String? id;
  String? cpf;
  String? name;
  String? email;
  String? password;
  List<String>? profiles;

  PersonModel(
      {this.id, this.cpf, this.name, this.email, this.password, this.profiles});

  PersonModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cpf = json['cpf'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    profiles = json['profiles'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['cpf'] = cpf;
    data['name'] = name;
    data['email'] = email;
    data['password'] = password;
    data['profiles'] = profiles;
    return data;
  }
}