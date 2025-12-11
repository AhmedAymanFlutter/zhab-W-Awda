// lib/features/home/data/repo/offers_repository.dart

import '../../../../../../core/network/api_endpoiont.dart';
import '../../../../../../core/network/api_helper.dart'; // Import your API Helper
import '../model/get_all_offers_model.dart';
import '../model/get_single_offer_model.dart';

class OffersRepository {
  final APIHelper _apiHelper = APIHelper(); // Access Singleton

  Future<GetAllOffersModel> getOffers() async {
    try {
      final response = await _apiHelper.getRequest(
        endPoint: EndPoints.offers,
        isProtected: false, // Set true if token is required
      );

      if (response.status == true && response.data != null) {
        // Parse JSON to Model
        return GetAllOffersModel.fromJson(response.data);
      } else {
        throw Exception(response.message);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<OfferItem> getOfferById(String id) async {
    try {
      // ✅ التصحيح: أضفنا / قبل كلمة admin
      final response = await _apiHelper.getRequest(
        endPoint: '${EndPoints.offers}admin/$id',
        isProtected: true,
      );

      if (response.status == true && response.data != null) {
        final model = GetSingleOfferModel.fromJson(response.data);
        if (model.data != null) {
          return model.data!;
        } else {
          throw Exception("لا توجد بيانات لهذا العرض");
        }
      } else {
        throw Exception(response.message);
      }
    } catch (e) {
      rethrow;
    }
  }
}
