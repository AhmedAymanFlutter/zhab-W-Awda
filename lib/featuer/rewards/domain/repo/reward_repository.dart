import 'package:dartz/dartz.dart';
import '../entity/reward_package_entity.dart';

abstract class RewardRepository {
  Future<Either<String, List<RewardPackageEntity>>> getRewardPackages({bool isActive = true});
}
