import 'package:get/get.dart';
import 'package:zenzi/modules/preference/controller/continue_button_controller.dart';
import 'package:zenzi/modules/preference/controller/progress_indicator_controller.dart';
import '../controller/topic_selection_controller.dart';

class PreferencePageBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TopicSelectionController>(() => TopicSelectionController());
    Get.lazyPut<ProgressIndicatorController>(
      () => ProgressIndicatorController(),
    );
    Get.lazyPut<ContinueButtonController>(() => ContinueButtonController());
  }
}
