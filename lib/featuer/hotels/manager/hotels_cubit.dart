import 'package:flutter_application_1/featuer/hotels/data/model/getHotel_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/repo/hotels_repository.dart';
import 'hotels_state.dart';
import '../data/model/get_countries_model.dart';

class HotelsCubit extends Cubit<HotelsState> {
  final HotelsRepository _repository;
  List<HotelItem> _allHotels = [];
  List<CountryItem> countries = [];
  HotelsCubit(this._repository) : super(HotelsInitial());

  static HotelsCubit get(context) => BlocProvider.of(context);

  Future<void> fetchHotels({
    String? city,
    String? query,
    String? checkIn,
    String? checkOut,
    String? country,
    int? adults,
    int? children,
  }) async {
    emit(HotelsLoading());

    try {
      final Map<String, dynamic> params = {};
      if (city != null && city.isNotEmpty) params['city'] = city;
      if (query != null && query.isNotEmpty) params['search'] = query;
      if (checkIn != null) params['checkIn'] = checkIn;
      if (checkOut != null) params['checkOut'] = checkOut;
      if (country != null && country.isNotEmpty) params['country'] = country;
      if (adults != null) params['adults'] = adults;
      if (children != null) params['children'] = children;

      final response = await _repository.getHotels(queryParameters: params);

      if (!isClosed) {
        if (response.data != null && response.data!.isNotEmpty) {
          List<HotelItem> hotels = response.data!;

          if (query != null && query.isNotEmpty) {
            final queryNorm = _normalize(query);
            hotels = hotels.where((hotel) {
              final name = _normalize(hotel.name ?? '');
              final translatedName = _normalize(hotel.translatedName ?? '');
              final cityName = _normalize(hotel.city?.name ?? '');
              final cityTrans = _normalize(hotel.cityTranslated ?? '');
              return name.contains(queryNorm) ||
                  translatedName.contains(queryNorm) ||
                  cityName.contains(queryNorm) ||
                  cityTrans.contains(queryNorm);
            }).toList();
          }

          if (city != null && city.isNotEmpty) {
            final cityNorm = _normalize(city);
            hotels = hotels.where((hotel) {
              final cityName = _normalize(hotel.city?.name ?? '');
              final cityTrans = _normalize(hotel.cityTranslated ?? '');
              return cityName.contains(cityNorm) ||
                  cityTrans.contains(cityNorm);
            }).toList();
          }

          if (country != null && country.isNotEmpty) {
            final countryNorm = _normalize(country);
            hotels = hotels.where((hotel) {
              final countryName = _normalize(hotel.country?.name ?? '');
              return countryName.contains(countryNorm);
            }).toList();
          }

          _allHotels = hotels;
          emit(HotelsSuccess(hotels));
        } else {
          emit(HotelsError("لا توجد فنادق متاحة حالياً"));
        }
      }
    } catch (e) {
      if (!isClosed) {
        emit(HotelsError(e.toString()));
      }
    }
  }

  String _normalize(String text) {
    if (text.isEmpty) return "";
    return text
        .replaceAll(RegExp(r'[أإآ]'), 'ا')
        .replaceAll('ة', 'ه')
        .replaceAll('ى', 'ي')
        .toLowerCase();
  }

  Future<void> getHotelDetails(String id) async {
    emit(HotelDetailsLoading());
    try {
      final result = await _repository.getHotelById(id);

      // ✅ التحقق هنا أيضاً
      if (!isClosed) {
        if (result.data != null) {
          emit(
            HotelDetailsSuccess(
              result.data!,
              relatedHotels: result.relatedHotels ?? [],
            ),
          );
        } else {
          emit(HotelDetailsError("لم يتم العثور على تفاصيل الفندق"));
        }
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
      final country = hotel.country?.name?.toLowerCase() ?? ''; // Added country
      final searchLower = query.toLowerCase();

      // Check if query matches title, city, OR country
      return title.contains(searchLower) ||
          city.contains(searchLower) ||
          country.contains(searchLower);
    }).toList();

    // ✅ وهنا
    if (!isClosed) emit(HotelsSuccess(filteredList));
  }

  Future<void> fetchHotelCountries() async {
    emit(HotelCountriesLoading());
    try {
      final response = await _repository.getHotelCountries();
      if (!isClosed) {
        if (response.data != null) {
          countries = response.data!;
          emit(HotelCountriesSuccess());
        } else {
          emit(HotelCountriesError("No countries found"));
        }
      }
    } catch (e) {
      if (!isClosed) {
        emit(HotelCountriesError(e.toString()));
      }
    }
  }
}
