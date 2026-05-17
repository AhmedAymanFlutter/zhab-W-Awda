import '../../domain/entity/reward_package_entity.dart';

class RewardPackageModel extends RewardPackageEntity {
  const RewardPackageModel({
    required super.id,
    required super.title,
    required super.description,
    required super.requiredPoints,
    required super.isActive,
  });

  factory RewardPackageModel.fromJson(Map<String, dynamic> json) {
    return RewardPackageModel(
      id: json['_id'] ?? "",
      title: json['title'] ?? "",
      description: json['description'] ?? "",
      requiredPoints: json['requiredPoints'] ?? 0,
      isActive: json['isActive'] ?? false,
    );
  }
}
