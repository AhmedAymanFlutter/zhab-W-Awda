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

      if (response.data != null) {
        emit(SettingsSuccess(response.data!));
      } else {
        emit(SettingsError("فشل في تحميل البيانات"));
      }
    } catch (e) {
      emit(SettingsError(e.toString()));
    }
  }
}
