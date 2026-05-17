import 'package:dartz/dartz.dart';
import '../../domain/entity/reward_package_entity.dart';
import '../../domain/repo/reward_repository.dart';
import '../source/reward_remote_data_source.dart';

class RewardRepositoryImpl implements RewardRepository {
  final RewardRemoteDataSource remoteDataSource;

  RewardRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<String, List<RewardPackageEntity>>> getRewardPackages({bool isActive = true}) async {
    try {
      final models = await remoteDataSource.getRewardPackages(isActive: isActive);
      return Right(models);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
