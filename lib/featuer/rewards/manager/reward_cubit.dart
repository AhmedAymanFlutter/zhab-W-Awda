import 'package:flutter_bloc/flutter_bloc.dart';
import '../domain/usecase/get_reward_packages_usecase.dart';
import 'reward_state.dart';

class RewardCubit extends Cubit<RewardState> {
  final GetRewardPackagesUseCase getRewardPackagesUseCase;

  RewardCubit(this.getRewardPackagesUseCase) : super(RewardInitial());

  Future<void> fetchRewardPackages() async {
    emit(RewardLoading());
    final result = await getRewardPackagesUseCase.call();
    result.fold(
      (error) => emit(RewardError(error)),
      (packages) => emit(RewardLoaded(packages)),
    );
  }
}
