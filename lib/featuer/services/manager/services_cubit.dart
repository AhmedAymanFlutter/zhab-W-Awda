import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/repo/services_repository.dart';
import 'services_state.dart';

class ServicesCubit extends Cubit<ServicesState> {
  final ServicesRepository _repository;

  ServicesCubit(this._repository) : super(ServicesInitial());

  static ServicesCubit get(context) => BlocProvider.of(context);

  Future<void> fetchServices() async {
    emit(ServicesLoading());

    try {
      final response = await _repository.getServices();

      // ✅ التحقق قبل إصدار الحالة بعد استجابة السيرفر
      if (!isClosed) {
        if (response.data != null &&
            response.data!.services != null &&
            response.data!.services!.isNotEmpty) {
          emit(ServicesSuccess(response.data!.services!));
        } else {
          emit(ServicesError("لا توجد خدمات متاحة حالياً"));
        }
      }
    } catch (e) {
      // ✅ التحقق عند حدوث خطأ
      if (!isClosed) {
        emit(ServicesError(e.toString()));
      }
    }
  }

  Future<void> getServiceDetails(String id) async {
    emit(ServiceDetailsLoading());
    try {
      final service = await _repository.getServiceById(id);

      // ✅ التحقق هنا أيضاً
      if (!isClosed) {
        emit(ServiceDetailsSuccess(service));
      }
    } catch (e) {
      // ✅ وهنا
      if (!isClosed) {
        emit(ServiceDetailsError(e.toString()));
      }
    }
  }
}
