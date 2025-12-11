import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/repo/tours_repository.dart';
import 'tours_state.dart';

class ToursCubit extends Cubit<ToursState> {
  final ToursRepository _repository;

  ToursCubit(this._repository) : super(ToursInitial());

  static ToursCubit get(context) => BlocProvider.of(context);

  Future<void> fetchTours() async {
    emit(ToursLoading());

    try {
      final response = await _repository.getTours();

      if (response.data != null &&
          response.data!.tours != null &&
          response.data!.tours!.isNotEmpty) {
        emit(ToursSuccess(response.data!.tours!));
      } else {
        emit(ToursError("لا توجد جولات متاحة حالياً"));
      }
    } catch (e) {
      emit(ToursError(e.toString()));
    }
  }

  Future<void> getTourDetails(String id) async {
    emit(TourDetailsLoading());
    try {
      final tour = await _repository.getTourById(id);
      emit(TourDetailsSuccess(tour));
    } catch (e) {
      emit(TourDetailsError(e.toString()));
    }
  }
}
