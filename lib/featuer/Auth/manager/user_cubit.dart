import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserState {
  final String name;
  final String? imagePath;
  final String? email;

  UserState({required this.name, this.imagePath, this.email});
}

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserState(name: "", imagePath: null));

  Future<void> saveUser({
    required String name,
    String? imagePath,
    String? email,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("user_name", name);
    if (imagePath != null) await prefs.setString("user_image", imagePath);
    await prefs.setString("user_email", "");

    emit(UserState(name: name, imagePath: imagePath));
  }

  Future<void> loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    final name = prefs.getString("user_name") ?? "";
    final image = prefs.getString("user_image");
    final email = prefs.getString("user_email");
    emit(UserState(name: name, imagePath: image, email: email));
  }
}
