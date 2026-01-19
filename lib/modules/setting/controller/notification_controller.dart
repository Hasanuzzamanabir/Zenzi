import 'package:get/get.dart';

class NotificationController extends GetxController {
  var meditateEnabled = true.obs;
  var sleepTimeEnabled = true.obs;
  var exerciseTimeEnabled = true.obs;

  void toggleMeditate(bool value) {
    meditateEnabled.value = value;
  }

  void toggleSleepTime(bool value) {
    sleepTimeEnabled.value = value;
  }

  void toggleExerciseTime(bool value) {
    exerciseTimeEnabled.value = value;
  }
}
