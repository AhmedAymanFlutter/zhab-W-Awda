import 'package:get_it/get_it.dart';
import 'package:flutter_application_1/core/network/api_helper.dart';
import 'package:flutter_application_1/featuer/Auth/manager/user_cubit.dart';
import 'package:flutter_application_1/featuer/global_setting/data/repo/settings_repository.dart';
import 'package:flutter_application_1/featuer/global_setting/manager/settings_cubit.dart';
import 'package:flutter_application_1/featuer/home/view/offer/data/repo/offers_repository.dart.dart';
import 'package:flutter_application_1/featuer/home/view/offer/manager/offers_cubit.dart';
import 'package:flutter_application_1/featuer/home/view/package/data/repo/package_repo.dart';
import 'package:flutter_application_1/featuer/home/view/package/manager/packages_cubit.dart';
import 'package:flutter_application_1/featuer/hotels/data/repo/hotels_repository.dart';
import 'package:flutter_application_1/featuer/hotels/manager/hotels_cubit.dart';
import 'package:flutter_application_1/featuer/countries/data/repo/countries_repository.dart';
import 'package:flutter_application_1/featuer/countries/manager/countries_cubit.dart';
import 'package:flutter_application_1/featuer/services/data/repo/services_repository.dart';
import 'package:flutter_application_1/featuer/services/manager/services_cubit.dart';
import 'package:flutter_application_1/featuer/Cities/data/repo/cities_repo.dart';
import 'package:flutter_application_1/featuer/Cities/manager/cities_cubit.dart';
import 'package:flutter_application_1/featuer/reviews/data/datasources/reviews_datasource.dart';
import 'package:flutter_application_1/featuer/reviews/data/repositories/review_repository_impl.dart';
import 'package:flutter_application_1/featuer/reviews/domain/repositories/review_repository.dart';
import 'package:flutter_application_1/featuer/reviews/presentation/manager/reviews_cubit.dart';
import 'package:flutter_application_1/featuer/tours/data/repo/tours_repository.dart';
import 'package:flutter_application_1/featuer/tours/manager/tours_cubit.dart';
import 'package:flutter_application_1/featuer/bookings/data/repo/bookings_repository.dart';
import 'package:flutter_application_1/featuer/bookings/manager/bookings_cubit.dart';
import 'package:flutter_application_1/featuer/bookings/manager/booking_details_cubit.dart';
import 'package:flutter_application_1/featuer/rewards/data/repo/reward_repository_impl.dart';
import 'package:flutter_application_1/featuer/rewards/domain/repo/reward_repository.dart';
import 'package:flutter_application_1/featuer/rewards/data/source/reward_remote_data_source.dart';
import 'package:flutter_application_1/featuer/rewards/domain/usecase/get_reward_packages_usecase.dart';
import 'package:flutter_application_1/featuer/rewards/manager/reward_cubit.dart';
import 'package:flutter_application_1/featuer/packageType/data/repo/package_types_repository.dart';
import 'package:flutter_application_1/featuer/packageType/manager/package_types_cubit.dart';

final getIt = GetIt.instance;

void setupDI() {
  // ---------------- Core ----------------
  getIt.registerLazySingleton<APIHelper>(() => APIHelper());

  // ---------------- Data Sources ----------------
  getIt.registerLazySingleton<IReviewsDataSource>(
    () => LocalReviewsDataSource(),
  );
  getIt.registerLazySingleton<RewardRemoteDataSource>(
    () => RewardRemoteDataSourceImpl(getIt<APIHelper>()),
  );

  // ---------------- Repositories ----------------
  getIt.registerLazySingleton<SettingsRepository>(() => SettingsRepository());
  getIt.registerLazySingleton<OffersRepository>(() => OffersRepository());
  getIt.registerLazySingleton<PackagesRepository>(() => PackagesRepository());
  getIt.registerLazySingleton<HotelsRepository>(() => HotelsRepository());
  getIt.registerLazySingleton<CountriesRepository>(() => CountriesRepository());
  getIt.registerLazySingleton<ServicesRepository>(() => ServicesRepository());
  getIt.registerLazySingleton<CitiesRepository>(() => CitiesRepository());
  getIt.registerLazySingleton<IReviewsRepository>(
    () => ReviewsRepositoryImpl(getIt<IReviewsDataSource>()),
  );
  getIt.registerLazySingleton<ToursRepository>(() => ToursRepository());
  getIt.registerLazySingleton<BookingsRepository>(() => BookingsRepository());
  getIt.registerLazySingleton<PackageTypesRepository>(
    () => PackageTypesRepository(),
  );
  getIt.registerLazySingleton<RewardRepository>(
    () => RewardRepositoryImpl(getIt<RewardRemoteDataSource>()),
  );

  getIt.registerLazySingleton<GetRewardPackagesUseCase>(
    () => GetRewardPackagesUseCase(getIt<RewardRepository>()),
  );

  getIt.registerLazySingleton<UserCubit>(() => UserCubit()..loadUser());
  getIt.registerLazySingleton<SettingsCubit>(
    () => SettingsCubit(getIt<SettingsRepository>())..fetchSettings(),
  );

  // Feature States (created as needed on demand)
  getIt.registerFactory<OffersCubit>(
    () => OffersCubit(getIt<OffersRepository>()),
  );
  getIt.registerFactory<PackagesCubit>(
    () => PackagesCubit(getIt<PackagesRepository>()),
  );
  getIt.registerFactory<HotelsCubit>(
    () => HotelsCubit(getIt<HotelsRepository>()),
  );
  getIt.registerFactory<CountriesCubit>(
    () => CountriesCubit(getIt<CountriesRepository>()),
  );
  getIt.registerFactory<ServicesCubit>(
    () => ServicesCubit(getIt<ServicesRepository>()),
  );
  getIt.registerFactory<CitiesCubit>(
    () => CitiesCubit(getIt<CitiesRepository>()),
  );
  getIt.registerFactory<ReviewsCubit>(
    () => ReviewsCubit(getIt<IReviewsRepository>()),
  );
  getIt.registerFactory<ToursCubit>(() => ToursCubit(getIt<ToursRepository>()));
  getIt.registerFactory<BookingsCubit>(
    () => BookingsCubit(getIt<BookingsRepository>()),
  );
  getIt.registerFactory<BookingDetailsCubit>(
    () => BookingDetailsCubit(getIt<BookingsRepository>()),
  );
  getIt.registerFactory<RewardCubit>(
    () => RewardCubit(getIt<GetRewardPackagesUseCase>()),
  );
  getIt.registerFactory<PackageTypesCubit>(
    () => PackageTypesCubit(getIt<PackageTypesRepository>()),
  );
}
