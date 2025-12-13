class UserModel {
  final String name;

  final String imagePath;

  UserModel({required this.name, required this.imagePath});

  Map<String, dynamic> toJson() => {"name": name, "imagePath": imagePath};

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      UserModel(name: json["name"] ?? "", imagePath: json["imagePath"] ?? "");
}
