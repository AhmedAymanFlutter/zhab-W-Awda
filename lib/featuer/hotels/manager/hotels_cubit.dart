import 'package:flutter_application_1/featuer/hotels/data/model/getHotel_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/repo/hotels_repository.dart';
import 'hotels_state.dart';

class HotelsCubit extends Cubit<HotelsState> {
  final HotelsRepository _repository;
  List<HotelItem> _allHotels = [];
  HotelsCubit(this._repository) : super(HotelsInitial());

  static HotelsCubit get(context) => BlocProvider.of(context);

  Future<void> fetchHotels() async {
    emit(HotelsLoading());

    try {
      final response = await _repository.getHotels();

      // ✅ التحقق قبل إصدار الحالة بعد جلب البيانات
      if (!isClosed) {
        if (response.data != null &&
            response.data!.hotels != null &&
            response.data!.hotels!.isNotEmpty) {
          _allHotels = response.data!.hotels!;
          emit(HotelsSuccess(response.data!.hotels!));
        } else {
          emit(HotelsError("لا توجد فنادق متاحة حالياً"));
        }
      }
    } catch (e) {
      // ✅ التحقق عند حدوث خطأ
      if (!isClosed) {
        emit(HotelsError(e.toString()));
      }
    }
  }

  Future<void> getHotelDetails(String slug) async {
    emit(HotelDetailsLoading());
    try {
      final hotel = await _repository.getHotelBySlug(slug);

      // ✅ التحقق هنا أيضاً
      if (!isClosed) {
        emit(HotelDetailsSuccess(hotel));
      }
    } catch (e) {
      // ✅ وهنا
      if (!isClosed) {
        emit(HotelDetailsError(e.toString()));
      }
    }
  }

  void searchLocalHotels(String query) {
    if (query.isEmpty) {
      // ✅ احتياطياً هنا
      if (!isClosed) emit(HotelsSuccess(_allHotels));
      return;
    }

    final filteredList = _allHotels.where((hotel) {
      final title = hotel.name?.toLowerCase() ?? '';
      final city = hotel.city?.name?.toLowerCase() ?? '';
      final searchLower = query.toLowerCase();

      return title.contains(searchLower) || city.contains(searchLower);
    }).toList();

    // ✅ وهنا
    if (!isClosed) emit(HotelsSuccess(filteredList));
  }
}
