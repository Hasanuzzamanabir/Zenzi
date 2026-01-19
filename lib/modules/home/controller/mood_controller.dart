import 'package:get/get.dart';

class MoodController extends GetxController {
  final moods = [
    {'emoji': '😊', 'label': 'Great'},
    {'emoji': '🙂', 'label': 'Good'},
    {'emoji': '😐', 'label': 'Okay'},
    {'emoji': '😔', 'label': 'Low'},
    {'emoji': '😰', 'label': 'Anxious'},
  ];
  final selectedMoodIndex = (-1).obs;
  void selectMood(int index) {
    selectedMoodIndex.value = index;
  }
}
