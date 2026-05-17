import 'package:dartz/dartz.dart';
import '../entity/reward_package_entity.dart';
import '../repo/reward_repository.dart';

class GetRewardPackagesUseCase {
  final RewardRepository repository;

  GetRewardPackagesUseCase(this.repository);

  Future<Either<String, List<RewardPackageEntity>>> call({bool isActive = true}) {
    return repository.getRewardPackages(isActive: isActive);
  }
}
