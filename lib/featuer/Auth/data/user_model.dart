class UserModel {
  final String name;
  final String email;
  final String password;
  final String imagePath;

  UserModel({
    required this.name,
    required this.email,
    required this.password,
    required this.imagePath,
  });

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "password": password,
    "imagePath": imagePath,
  };

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    name: json["name"] ?? "",
    email: json["email"] ?? "",
    password: json["password"] ?? "",
    imagePath: json["imagePath"] ?? "",
  );
}
