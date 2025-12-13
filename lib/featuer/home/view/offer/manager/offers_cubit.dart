import 'package:flutter_application_1/featuer/home/view/offer/data/model/get_all_offers_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/repo/offers_repository.dart.dart';
import 'offers_state.dart';

class OffersCubit extends Cubit<OffersState> {
  final OffersRepository _repository;
  List<OfferItem> _allOffers = [];
  OffersCubit(this._repository) : super(OffersInitial());

  static OffersCubit get(context) => BlocProvider.of(context);

  // 1. Fetch All Offers (للصفحة الرئيسية)
  Future<void> fetchOffers() async {
    emit(OffersListLoading());

    try {
      final responseModel = await _repository.getOffers();

      // ✅ التحقق قبل إصدار الحالة بعد الـ await
      if (!isClosed) {
        if (responseModel.data != null &&
            responseModel.data!.offersList != null &&
            responseModel.data!.offersList!.isNotEmpty) {
          _allOffers = responseModel.data!.offersList!;
          emit(OffersListSuccess(responseModel.data!.offersList!));
        } else {
          emit(OffersListError("لا توجد عروض متاحة حالياً"));
        }
      }
    } catch (e) {
      // ✅ التحقق عند حدوث خطأ
      if (!isClosed) {
        emit(OffersListError(e.toString()));
      }
    }
  }

  // 2. Get Offer Details (لصفحة التفاصيل)
  Future<void> getOfferDetails(String id) async {
    emit(OfferDetailsLoading());

    try {
      final offer = await _repository.getOfferById(id);

      // ✅ التحقق هنا أيضاً
      if (!isClosed) {
        emit(OfferDetailsSuccess(offer));
      }
    } catch (e) {
      // ✅ وهنا
      if (!isClosed) {
        emit(OfferDetailsError(e.toString()));
      }
    }
  }

  void searchLocalOffers(String query) {
    if (query.isEmpty) {
      // ✅ يفضل وضعه هنا أيضاً احتياطياً
      if (!isClosed) emit(OffersListSuccess(_allOffers));
      return;
    }

    final lowerQuery = query.toLowerCase();

    final filteredList = _allOffers.where((offer) {
      final title = offer.name?.toLowerCase() ?? '';
      final description = offer.description?.toLowerCase() ?? '';

      return title.contains(lowerQuery) || description.contains(lowerQuery);
    }).toList();

    // ✅ وهنا
    if (!isClosed) emit(OffersListSuccess(filteredList));
  }
}
