import 'package:equatable/equatable.dart';
import '../domain/entity/reward_package_entity.dart';

abstract class RewardState extends Equatable {
  const RewardState();

  @override
  List<Object?> get props => [];
}

class RewardInitial extends RewardState {}

class RewardLoading extends RewardState {}

class RewardLoaded extends RewardState {
  final List<RewardPackageEntity> packages;

  const RewardLoaded(this.packages);

  @override
  List<Object?> get props => [packages];
}

class RewardError extends RewardState {
  final String message;

  const RewardError(this.message);

  @override
  List<Object?> get props => [message];
}
