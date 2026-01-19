import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_application_1/core/theme/app_color.dart';
import 'package:flutter_application_1/core/theme/app_text_style.dart';
import '../../../manager/rate_package_cubit.dart';
import '../../../manager/rate_package_state.dart';
import '../../../data/repo/package_repo.dart';

class RatePackageDialog extends StatefulWidget {
  final String packageId;

  const RatePackageDialog({super.key, required this.packageId});

  @override
  State<RatePackageDialog> createState() => _RatePackageDialogState();
}

class _RatePackageDialogState extends State<RatePackageDialog> {
  final _formKey = GlobalKey<FormState>();
  double _rating = 0;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RatePackageCubit(PackagesRepository()),
      child: BlocConsumer<RatePackageCubit, RatePackageState>(
        listener: (context, state) {
          if (state is RatePackageSuccess) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.green,
              ),
            );
          } else if (state is RatePackageError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is RatePackageLoading;

          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Padding(
              padding: EdgeInsets.all(20.w),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "قيم الباقة",
                        style: AppTextStyle.setelMessiriBlack(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20.h),

                      // Star Rating
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(5, (index) {
                          return IconButton(
                            icon: Icon(
                              index < _rating ? Icons.star : Icons.star_border,
                              color: Colors.amber,
                              size: 32.sp,
                            ),
                            onPressed: () {
                              setState(() {
                                _rating = index + 1.0;
                              });
                            },
                          );
                        }),
                      ),
                      SizedBox(height: 16.h),

                      // Name Field
                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          hintText: "الاسم",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 12.h,
                          ),
                        ),
                        validator: (value) =>
                            value == null || value.isEmpty ? "مطلوب" : null,
                      ),
                      SizedBox(height: 12.h),

                      // Comment Field
                      TextFormField(
                        controller: _commentController,
                        maxLines: 3,
                        decoration: InputDecoration(
                          hintText: "تعليقك",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 12.h,
                          ),
                        ),
                        validator: (value) =>
                            value == null || value.isEmpty ? "مطلوب" : null,
                      ),
                      SizedBox(height: 20.h),

                      // Submit Button
                      SizedBox(
                        width: double.infinity,
                        height: 48.h,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.primaryBlue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                          ),
                          onPressed: isLoading
                              ? null
                              : () {
                                  if (_formKey.currentState!.validate()) {
                                    if (_rating == 0) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text("يرجى اختيار التقييم"),
                                        ),
                                      );
                                      return;
                                    }
                                    context
                                        .read<RatePackageCubit>()
                                        .ratePackage(
                                          packageId: widget.packageId,
                                          rating: _rating,
                                          comment: _commentController.text,
                                          userName: _nameController.text,
                                        );
                                  }
                                },
                          child: isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : Text(
                                  "إرسال التقييم",
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
