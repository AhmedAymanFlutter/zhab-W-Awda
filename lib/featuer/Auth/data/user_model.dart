class UserModel {
  final String id;
  final String name;
  final String countryCode;
  final String phone;
  final String role;
  final bool isEmailVerified;
  final bool isPhoneVerified;
  final bool isActive;
  final String token;

  UserModel({
    required this.id,
    required this.name,
    required this.countryCode,
    required this.phone,
    required this.role,
    required this.isEmailVerified,
    required this.isPhoneVerified,
    required this.isActive,
    required this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      countryCode: json['countryCode'] ?? '',
      phone: json['phone'] ?? '',
      role: json['role'] ?? '',
      isEmailVerified: json['isEmailVerified'] ?? false,
      isPhoneVerified: json['isPhoneVerified'] ?? false,
      isActive: json['isActive'] ?? false,
      token: json['token'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'countryCode': countryCode,
      'phone': phone,
      'role': role,
      'isEmailVerified': isEmailVerified,
      'isPhoneVerified': isPhoneVerified,
      'isActive': isActive,
      'token': token,
    };
  }
}
