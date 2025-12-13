import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/repo/settings_repository.dart';
import 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final SettingsRepository _repository;

  SettingsCubit(this._repository) : super(SettingsInitial());

  static SettingsCubit get(context) => BlocProvider.of(context);

  Future<void> fetchSettings() async {
    emit(SettingsLoading());

    try {
      final response = await _repository.getSettings();

      // ✅ التحقق قبل إصدار الحالة بعد انتظار الرد
      if (!isClosed) {
        if (response.data != null) {
          emit(SettingsSuccess(response.data!));
        } else {
          emit(SettingsError("فشل في تحميل البيانات"));
        }
      }
    } catch (e) {
      // ✅ التحقق قبل إصدار حالة الخطأ
      if (!isClosed) {
        emit(SettingsError(e.toString()));
      }
    }
  }
}
