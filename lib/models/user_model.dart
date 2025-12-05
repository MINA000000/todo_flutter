class UserModel {
  String id;
  String name;
  String email;
  UserModel({required this.email, required this.id, required this.name});
  UserModel.fromJson(Map<String, dynamic> json)
    : this(email: json['email'], id: json['id'], name: json['name']);
  toJson() => {'email': email, 'id': id, 'name': name};
}
