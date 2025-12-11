import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/repo/offers_repository.dart.dart';
import 'offers_state.dart';

class OffersCubit extends Cubit<OffersState> {
  final OffersRepository _repository;

  OffersCubit(this._repository) : super(OffersInitial());

  static OffersCubit get(context) => BlocProvider.of(context);

  // 1. Fetch All Offers (للصفحة الرئيسية)
  Future<void> fetchOffers() async {
    // نستخدم emit فقط إذا لم يكن هناك بيانات سابقة لتجنب الوميض، أو نجبرها
    emit(OffersListLoading());

    try {
      final responseModel = await _repository.getOffers();
      print(responseModel.data);
      if (responseModel.data != null &&
          responseModel.data!.offersList != null &&
          responseModel.data!.offersList!.isNotEmpty) {
        emit(OffersListSuccess(responseModel.data!.offersList!));
      } else {
        emit(OffersListError("لا توجد عروض متاحة حالياً"));
      }
    } catch (e) {
      emit(OffersListError(e.toString()));
    }
  }

  // 2. Get Offer Details (لصفحة التفاصيل)
  Future<void> getOfferDetails(String id) async {
    emit(OfferDetailsLoading());

    try {
      final offer = await _repository.getOfferById(id);
      print(offer);
      emit(OfferDetailsSuccess(offer));
    } catch (e) {
      emit(OfferDetailsError(e.toString()));
    }
  }
}
