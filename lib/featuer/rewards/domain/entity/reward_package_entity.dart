import 'package:equatable/equatable.dart';

class RewardPackageEntity extends Equatable {
  final String id;
  final String title;
  final String description;
  final int requiredPoints;
  final bool isActive;

  const RewardPackageEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.requiredPoints,
    required this.isActive,
  });

  @override
  List<Object?> get props => [id, title, description, requiredPoints, isActive];
}
