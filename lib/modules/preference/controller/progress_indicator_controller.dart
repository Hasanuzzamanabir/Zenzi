import 'package:get/get.dart';

class ProgressIndicatorController extends GetxController{
  final int totalSteps = 3;
  final RxInt currentStep = 1.obs;

  double get progressValue => currentStep.value / totalSteps;

  void nextStep() {
    if (currentStep.value < totalSteps) {
      currentStep.value++;
    }
  }

  void previousStep() {
    if (currentStep.value > 1) {
      currentStep.value--;
    }
  }
}