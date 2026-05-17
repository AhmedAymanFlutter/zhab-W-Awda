import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/theme/app_text_style.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../manager/reward_cubit.dart';
import '../manager/reward_state.dart';
import 'widgets/reward_package_card.dart';
import 'widgets/rewards_balance_card.dart';

class RewardsView extends StatefulWidget {
  const RewardsView({super.key});

  @override
  State<RewardsView> createState() => _RewardsViewState();
}

class _RewardsViewState extends State<RewardsView> {
  @override
  void initState() {
    super.initState();
    context.read<RewardCubit>().fetchRewardPackages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "المكافآت",
          style: AppTextStyle.setelMessiriBlack(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocBuilder<RewardCubit, RewardState>(
        builder: (context, state) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const RewardsBalanceCard(currentPoints: 400),
                SizedBox(height: 32.h),
                Text(
                  "استبدل نقاطك بباقات",
                  style: AppTextStyle.setelMessiriBlack(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16.h),
                if (state is RewardLoading)
                  const Center(child: CircularProgressIndicator())
                else if (state is RewardError)
                  Center(child: Text(state.message))
                else if (state is RewardLoaded)
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.packages.length,
                    itemBuilder: (context, index) {
                      final package = state.packages[index];
                      return RewardPackageCard(
                        title: package.title,
                        description: package.description,
                        requiredPoints: package.requiredPoints,
                      );
                    },
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
