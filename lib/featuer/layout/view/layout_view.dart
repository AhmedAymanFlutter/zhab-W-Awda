import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/di/dependency_injection.dart';
import '../../../core/theme/app_color.dart';
import '../../../core/network/network_error_manager.dart';
import '../../../core/widgets/network_retry_wrapper.dart';
import '../logic/layout_cubit.dart';
import '../logic/layout_state.dart';
import 'widgets/custom_drawer.dart';
import 'widgets/custom_convex_bottom_bar.dart';
import '../../home/view/offer/manager/offers_cubit.dart';
import '../../home/view/package/manager/packages_cubit.dart';
import '../../hotels/manager/hotels_cubit.dart';
import '../../countries/manager/countries_cubit.dart';
import '../../Cities/manager/cities_cubit.dart';
import '../../tours/manager/tours_cubit.dart';
import '../../services/manager/services_cubit.dart';
import '../../packageType/manager/package_types_cubit.dart';

class LayoutView extends StatelessWidget {
  const LayoutView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LayoutCubit()),
        BlocProvider(create: (context) => getIt<OffersCubit>()..fetchOffers()),
        BlocProvider(
          create: (context) => getIt<PackagesCubit>()..fetchPackages(),
        ),
        BlocProvider(create: (context) => getIt<HotelsCubit>()..fetchHotels()),
        BlocProvider(
          create: (context) => getIt<CountriesCubit>()..fetchCountries(),
        ),
        BlocProvider(create: (context) => getIt<CitiesCubit>()..fetchCities()),
        BlocProvider(create: (context) => getIt<ToursCubit>()..fetchTours()),
        BlocProvider(
          create: (context) => getIt<ServicesCubit>()..fetchServices(),
        ),
        BlocProvider(
          create: (context) => getIt<PackageTypesCubit>()..fetchPackageTypes(),
        ),
      ],
      child: BlocBuilder<LayoutCubit, LayoutState>(
        builder: (context, state) {
          final cubit = LayoutCubit.get(context);

          return ValueListenableBuilder<String?>(
            valueListenable: NetworkErrorManager.connectionErrorNotifier,
            builder: (context, errorMessage, child) {
              return NetworkRetryWrapper(
                hasError: errorMessage != null,
                errorMessage: errorMessage,
                onRetry: () async {
                  final activeIndex = cubit.currentIndex;
                  if (activeIndex == 4) {
                    _refreshHomeData(context);
                  } else if (activeIndex == 3) {
                    await context.read<ToursCubit>().fetchTours();
                  } else if (activeIndex == 1) {
                    await context.read<PackageTypesCubit>().fetchPackageTypes();
                  }
                  NetworkErrorManager.clearError();
                },
                child: Scaffold(
                  extendBody: true,
                  backgroundColor: AppColor.primaryWhite,
                  drawer: const CustomDrawer(),
                  body: cubit.screens[cubit.currentIndex],
                  bottomNavigationBar: CustomConvexBottomBar(
                    cubit: cubit,
                    onHomeTap: () => _refreshHomeData(context),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _refreshHomeData(BuildContext context) {
    context.read<ToursCubit>().fetchTours();
    context.read<HotelsCubit>().fetchHotels();
    context.read<PackagesCubit>().fetchPackages();
    context.read<OffersCubit>().fetchOffers();
    context.read<CitiesCubit>().fetchCities();
    context.read<CountriesCubit>().fetchCountries();
    context.read<ServicesCubit>().fetchServices();
  }
}
