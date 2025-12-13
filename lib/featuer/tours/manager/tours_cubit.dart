import 'package:flutter_application_1/featuer/tours/data/model/get_all_tours_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/repo/tours_repository.dart';
import 'tours_state.dart';

class ToursCubit extends Cubit<ToursState> {
  final ToursRepository _repository;
  List<TourItem> tours = [];
  ToursCubit(this._repository) : super(ToursInitial());

  static ToursCubit get(context) => BlocProvider.of(context);

  Future<void> fetchTours() async {
    emit(ToursLoading());

    try {
      final response = await _repository.getTours();

      // ✅ التحقق قبل إصدار الحالة بعد جلب البيانات
      if (!isClosed) {
        if (response.data != null &&
            response.data!.tours != null &&
            response.data!.tours!.isNotEmpty) {
          tours = response.data!.tours!;
          emit(ToursSuccess(response.data!.tours!));
        } else {
          emit(ToursError("لا توجد جولات متاحة حالياً"));
        }
      }
    } catch (e) {
      // ✅ التحقق عند حدوث خطأ
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
      if (!isClosed) emit(ToursSuccess(tours));
      return;
    }

    final lowerQuery = query.toLowerCase();

    final filteredTours = tours.where((tour) {
      final title = tour.title?.toLowerCase() ?? '';
      final cityName = tour.city?.name?.toLowerCase() ?? '';

      return title.contains(lowerQuery) || cityName.contains(lowerQuery);
    }).toList();

    // ✅ وهنا
    if (!isClosed) emit(ToursSuccess(filteredTours));
  }
}
