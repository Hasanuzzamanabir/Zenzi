import 'package:get/get.dart';
import '../controller/mood_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<MoodController>(MoodController());
  }
}
