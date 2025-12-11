import '../data/models/get_settings_model.dart';

abstract class SettingsState {}

class SettingsInitial extends SettingsState {}

class SettingsLoading extends SettingsState {}

class SettingsSuccess extends SettingsState {
  final SettingsData settings;
  SettingsSuccess(this.settings);
}

class SettingsError extends SettingsState {
  final String message;
  SettingsError(this.message);
}
