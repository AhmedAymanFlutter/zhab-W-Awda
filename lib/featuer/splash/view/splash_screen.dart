import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/router/routes.dart';
import 'package:flutter_application_1/core/theme/app_color.dart';
import 'package:flutter_application_1/featuer/Auth/manager/user_cubit.dart';
import 'package:flutter_application_1/featuer/Auth/manager/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  bool _navigated = false;

  @override
  void initState() {
    super.initState();

    // Animation Setup
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    _animationController.forward();

    // Safety check: if the state is already determined after the animation
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted && !_navigated) {
        final state = context.read<UserCubit>().state;
        if (state is! AuthLoading) {
          _navigateToNext(state);
        }
      }
    });
  }

  void _navigateToNext(AuthState state) {
    if (!mounted || _navigated) return;
    _navigated = true;
    
    if (state is AuthVerifySuccess) {
      Navigator.pushReplacementNamed(context, Routes.layout);
    } else {
      Navigator.pushReplacementNamed(context, Routes.loginView);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserCubit, AuthState>(
      listener: (context, state) {
        if (state is! AuthLoading) {
          // Wait for animation to finish or at least 2 seconds
          Future.delayed(const Duration(seconds: 2), () {
            _navigateToNext(state);
          });
        }
      },
      child: Scaffold(
        backgroundColor: AppColor.mainWhite,
        body: Center(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Image.asset(
              'assets/photo/mainLogo.webp',
              width: 250.w,
              height: 250.h,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
