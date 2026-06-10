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
    if (cityId == null && priceRange == null && page != 1) {
      currentPage = page;
    } else {
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
          print("========= TOURS PARSED SUCCESSFULLY =========");
          print("Tours count: ${tours.length}");
          emit(ToursSuccess(tours, pagination: pagination));
        } else {
          print("========= TOURS PARSING FAILED or EMPTY =========");
          print("response.data: ${response.data}");
          print("response.data!.tours: ${response.data?.tours}");
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

  Future<void> fetchSavedTours({String? query}) async {
    emit(SavedToursLoading());
    try {
      final response = await _repository.getSavedTours(query: query);
      if (!isClosed) {
        if (response.data?.tours != null) {
          final savedTours = response.data!.tours!;
          for (var tour in savedTours) {
            tour.isSaved = true;
          }
          emit(SavedToursSuccess(savedTours));
        } else {
          emit(SavedToursError("لا توجد جولات محفوظة"));
        }
      }
    } catch (e) {
      if (!isClosed) {
        emit(SavedToursError(e.toString()));
      }
    }
  }

  Future<void> toggleSaveTour(String id) async {
    final currentState = state;
    TourItem? mainTour;
    int? mainTourIndex;

    // 1. Local update for main tours list (Optimistic)
    mainTourIndex = tours.indexWhere((t) => (t.sId ?? t.id) == id);
    if (mainTourIndex != -1) {
      mainTour = tours[mainTourIndex];
      mainTour.isSaved = !(mainTour.isSaved ?? false);
    }

    // 2. Local update for SavedToursSuccess state (Optimistic)
    List<TourItem>? updatedSavedTours;
    TourItem? removedTour;
    int? removedTourIndex;

    bool isSaving = true;
    if (currentState is SavedToursSuccess) {
      isSaving = false;
      updatedSavedTours = List.from(currentState.tours);
      removedTourIndex = updatedSavedTours.indexWhere(
        (t) => (t.sId ?? t.id) == id,
      );
      if (removedTourIndex != -1) {
        removedTour = updatedSavedTours.removeAt(removedTourIndex);
      }
      emit(SavedToursSuccess(updatedSavedTours));
    } else if (currentState is TourDetailsSuccess) {
      currentState.tour.isSaved = !(currentState.tour.isSaved ?? false);
      emit(TourDetailsSuccess(currentState.tour));
    } else if (currentState is ToursSuccess) {
      if (mainTour != null) {
        isSaving = mainTour.isSaved ?? false;
      }
      emit(ToursSuccess(List.from(tours), pagination: pagination));
    }

    try {
      final response = await _repository.toggleSaveTour(id, isSaving);

      if (response.status != true) {
        // Rollback
        _rollbackToggle(
          id,
          mainTourIndex,
          currentState,
          removedTour,
          removedTourIndex,
        );
        if (!isClosed) emit(ToursError(response.message));
      }
    } catch (e) {
      // Rollback
      _rollbackToggle(
        id,
        mainTourIndex,
        currentState,
        removedTour,
        removedTourIndex,
      );
      if (!isClosed) emit(ToursError(e.toString()));
    }
  }

  void _rollbackToggle(
    String id,
    int? mainTourIndex,
    ToursState previousState,
    TourItem? removedTour,
    int? removedTourIndex,
  ) {
    // Rollback main list
    if (mainTourIndex != null && mainTourIndex != -1) {
      tours[mainTourIndex].isSaved = !(tours[mainTourIndex].isSaved ?? false);
    }

    // Rollback state
    if (previousState is SavedToursSuccess &&
        removedTour != null &&
        removedTourIndex != null) {
      final list = List<TourItem>.from(previousState.tours);
      emit(SavedToursSuccess(list));
    } else if (previousState is ToursSuccess) {
      emit(ToursSuccess(List.from(tours), pagination: pagination));
    }
  }
}
