import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zenzi/core/bindings/controller_binder.dart';
import 'package:zenzi/core/services/alarm_notification_service.dart';
import 'package:zenzi/core/theme/app_theme.dart';
import 'package:zenzi/routes/app_routes.dart';

class Zenzi extends StatefulWidget {
  const Zenzi({super.key});

  @override
  State<Zenzi> createState() => _ZenziState();
}

class _ZenziState extends State<Zenzi> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      unawaited(AlarmNotificationService.instance.initialize());
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          title: 'Zenzi',
          debugShowCheckedModeBanner: false,
          initialRoute: AppRoute.splashView,
          getPages: AppRoute.routes,
          initialBinding: ControllerBinder(),
          themeMode: ThemeMode.system,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
        );
      },
    );
  }
}
