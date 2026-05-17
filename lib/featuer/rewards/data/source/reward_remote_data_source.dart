import '../../../../core/network/api_endpoiont.dart';
import '../../../../core/network/api_helper.dart';
import '../model/reward_package_model.dart';

abstract class RewardRemoteDataSource {
  Future<List<RewardPackageModel>> getRewardPackages({bool isActive = true});
}

class RewardRemoteDataSourceImpl implements RewardRemoteDataSource {
  final APIHelper apiHelper;

  RewardRemoteDataSourceImpl(this.apiHelper);

  @override
  Future<List<RewardPackageModel>> getRewardPackages({bool isActive = true}) async {
    final response = await apiHelper.getRequest(
      endPoint: EndPoints.rewardPackages,
      queryParameters: {'isActive': isActive.toString()},
      isProtected: true,
    );
    
    if (response.status == true && response.data != null && response.data is Map) {
      final List? packagesData = (response.data as Map<String, dynamic>)['data'];
      if (packagesData != null) {
        return packagesData
            .map((item) => RewardPackageModel.fromJson(item))
            .toList();
      }
    }
    return [];
  }
}
