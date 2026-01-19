import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zenzi/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  // Initialize AuthService
  // Get.put(AuthService());
  // Initialize CartController
  // Get.put(CartController());

  runApp(const Zenzi());
}
