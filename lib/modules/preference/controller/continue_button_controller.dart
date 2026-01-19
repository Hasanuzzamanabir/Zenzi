import 'package:get/get.dart';
import 'topic_selection_controller.dart';

class ContinueButtonController extends GetxController {

  final TopicSelectionController selectionController =
      Get.find<TopicSelectionController>();

  bool get isEnabled => selectionController.hasSelection;
}