// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zenzi/core/theme/app_colors.dart';
import 'package:zenzi/core/values/app_assets.dart';
import 'package:zenzi/modules/just breathe/view/just_breathe_view.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int activeIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    /// 🔁 loading dots loop
    _timer = Timer.periodic(const Duration(milliseconds: 300), (_) {
      setState(() {
        activeIndex = (activeIndex + 1) % 3;
      });
    });

    // Redirect to JustBreathePageView after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const JustBreathePageView()),
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.splashcolorone, AppColors.splashcolortwo],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// 🔹 LOGO
            Spacer(),
            SvgPicture.asset(AppAssets.splashLogo, width: 110.w),

            //SizedBox(height: 100.h),
            Spacer(),

            /// 🔹 LOADING DOTS
            Padding(
              padding: EdgeInsets.only(bottom: 60.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  3,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    margin: EdgeInsets.symmetric(horizontal: 6.w),
                    width: activeIndex == index ? 10.w : 10.w,
                    height: 10.h,
                    decoration: BoxDecoration(
                      color: activeIndex == index
                          ? Colors.amber
                          : Colors.amber.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
