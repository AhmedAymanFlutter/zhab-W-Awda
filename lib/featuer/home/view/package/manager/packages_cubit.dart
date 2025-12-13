import 'package:flutter_application_1/featuer/home/view/package/data/model/get_all_packages_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/repo/package_repo.dart';
import 'packages_state.dart';

class PackagesCubit extends Cubit<PackagesState> {
  final PackagesRepository _repository;
  List<PackageItem> _allPackages = [];
  PackagesCubit(this._repository) : super(PackagesInitial());

  static PackagesCubit get(context) => BlocProvider.of(context);

  Future<void> fetchPackages() async {
    emit(PackagesLoading());

    try {
      final response = await _repository.getPackages();

      // ✅ التحقق قبل إصدار الحالة بعد انتظار السيرفر
      if (!isClosed) {
        if (response.data != null &&
            response.data!.packages != null &&
            response.data!.packages!.isNotEmpty) {
          _allPackages = response.data!.packages!;
          emit(PackagesSuccess(response.data!.packages!));
        } else {
          emit(PackagesError("لا توجد باقات متاحة حالياً"));
        }
      }
    } catch (e) {
      // ✅ التحقق قبل إصدار حالة الخطأ
      if (!isClosed) {
        emit(PackagesError(e.toString()));
      }
    }
  }

  Future<void> getPackageDetails(String id) async {
    emit(PackageDetailsLoading());

    try {
      final package = await _repository.getPackageById(id);

      // ✅ التحقق هنا أيضاً
      if (!isClosed) {
        emit(PackageDetailsSuccess(package));
      }
    } catch (e) {
      // ✅ وهنا
      if (!isClosed) {
        emit(PackageDetailsError(e.toString()));
      }
    }
  }

  void searchLocalPackages(String query) {
    if (query.isEmpty) {
      if (!isClosed) emit(PackagesSuccess(_allPackages));
      return;
    }

    final lowerQuery = query.toLowerCase();

    final filteredList = _allPackages.where((package) {
      // تأكد أنك تبحث في الحقول الصحيحة (هنا تبحث في city، يمكنك إضافة title أو description)
      final cityName = package.city?.toLowerCase() ?? '';
      // final title = package.title?.toLowerCase() ?? ''; // مثال إذا أردت البحث بالعنوان أيضاً

      return cityName.contains(lowerQuery);
    }).toList();

    if (!isClosed) emit(PackagesSuccess(filteredList));
  }
}
