import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/repo/hotels_repository.dart';
import 'hotels_state.dart';

class HotelsCubit extends Cubit<HotelsState> {
  final HotelsRepository _repository;

  HotelsCubit(this._repository) : super(HotelsInitial());

  static HotelsCubit get(context) => BlocProvider.of(context);

  Future<void> fetchHotels() async {
    emit(HotelsLoading());

    try {
      final response = await _repository.getHotels();

      if (response.data != null &&
          response.data!.hotels != null &&
          response.data!.hotels!.isNotEmpty) {
        emit(HotelsSuccess(response.data!.hotels!));
      } else {
        emit(HotelsError("لا توجد فنادق متاحة حالياً"));
      }
    } catch (e) {
      emit(HotelsError(e.toString()));
    }
  }

  Future<void> getHotelDetails(String id) async {
    emit(HotelDetailsLoading());
    try {
      final hotel = await _repository.getHotelById(id);
      emit(HotelDetailsSuccess(hotel));
    } catch (e) {
      emit(HotelDetailsError(e.toString()));
    }
  }
}
