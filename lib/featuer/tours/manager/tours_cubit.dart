import 'package:flutter_application_1/featuer/tours/data/model/get_all_tours_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/repo/tours_repository.dart';
import 'tours_state.dart';

class ToursCubit extends Cubit<ToursState> {
  final ToursRepository _repository;
  List<TourItem> tours = [];
  Pagination? pagination;
  String? selectedCityId;
  String? selectedPriceRange;
  int currentPage = 1;

  ToursCubit(this._repository) : super(ToursInitial());

  static ToursCubit get(context) => BlocProvider.of(context);

  Future<void> fetchTours({
    String? cityId,
    String? priceRange,
    int page = 1,
  }) async {
    // If we are calling for a specific page without changing filters
    if (cityId == null && priceRange == null && page != 1) {
      currentPage = page;
    } else {
      // If we are changing filters or resetting to "All"
      selectedCityId = cityId;
      selectedPriceRange = priceRange;
      currentPage = page;
    }

    emit(ToursLoading());

    try {
      final Map<String, dynamic> params = {'page': currentPage};
      if (selectedCityId != null) params['city'] = selectedCityId;
      if (selectedPriceRange != null) params['price'] = selectedPriceRange;

      final response = await _repository.getTours(queryParameters: params);

      if (!isClosed) {
        if (response.data != null && response.data!.tours != null) {
          tours = response.data!.tours!;
          pagination = response.data!.pagination;
          emit(ToursSuccess(tours, pagination: pagination));
        } else {
          emit(ToursError("لا توجد جولات متاحة حالياً"));
        }
      }
    } catch (e) {
      if (!isClosed) {
        emit(ToursError(e.toString()));
      }
    }
  }

  Future<void> getTourDetails(String id) async {
    emit(TourDetailsLoading());
    try {
      final tour = await _repository.getTourById(id);

      // ✅ التحقق هنا أيضاً
      if (!isClosed) {
        emit(TourDetailsSuccess(tour));
      }
    } catch (e) {
      // ✅ وهنا
      if (!isClosed) {
        emit(TourDetailsError(e.toString()));
      }
    }
  }

  void searchLocalTours(String query) {
    if (query.isEmpty) {
      // ✅ يفضل التحقق هنا
      if (!isClosed) emit(ToursSuccess(tours, pagination: pagination));
      return;
    }

    final lowerQuery = query.toLowerCase();

    final filteredTours = tours.where((tour) {
      final title = tour.title?.toLowerCase() ?? '';
      final cityName = tour.city?.name?.toLowerCase() ?? '';

      return title.contains(lowerQuery) || cityName.contains(lowerQuery);
    }).toList();

    // ✅ وهنا
    if (!isClosed) emit(ToursSuccess(filteredTours, pagination: null));
  }
}
