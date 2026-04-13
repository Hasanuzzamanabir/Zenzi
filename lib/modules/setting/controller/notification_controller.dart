import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zenzi/core/services/alarm_notification_service.dart';

class NotificationController extends GetxController {
  NotificationController();

  static const int meditateAlarmId = 101;
  static const int sleepAlarmId = 102;
  static const int exerciseAlarmId = 103;

  static const String meditateKey = 'notification_meditate_enabled';
  static const String sleepKey = 'notification_sleep_enabled';
  static const String exerciseKey = 'notification_exercise_enabled';

  final GetStorage _storage = GetStorage();

  var meditateEnabled = false.obs;
  var sleepTimeEnabled = false.obs;
  var exerciseTimeEnabled = false.obs;

  @override
  void onInit() {
    super.onInit();
    meditateEnabled.value = _storage.read<bool>(meditateKey) ?? false;
    sleepTimeEnabled.value = _storage.read<bool>(sleepKey) ?? false;
    exerciseTimeEnabled.value = _storage.read<bool>(exerciseKey) ?? false;
  }

  void toggleMeditate(bool value) async {
    meditateEnabled.value = value;
    _storage.write(meditateKey, value);
    await _applyAlarmState(
      enabled: value,
      alarmId: meditateAlarmId,
      title: 'Set Meditation Time',
    );
  }

  void toggleSleepTime(bool value) async {
    sleepTimeEnabled.value = value;
    _storage.write(sleepKey, value);
    await _applyAlarmState(
      enabled: value,
      alarmId: sleepAlarmId,
      title: 'Set Sleeping time',
    );
  }

  void toggleExerciseTime(bool value) async {
    exerciseTimeEnabled.value = value;
    _storage.write(exerciseKey, value);
    await _applyAlarmState(
      enabled: value,
      alarmId: exerciseAlarmId,
      title: 'Set breathing exercise time',
    );
  }

  Future<void> _applyAlarmState({
    required bool enabled,
    required int alarmId,
    required String title,
  }) async {
    if (!enabled) {
      await AlarmNotificationService.instance.cancelAlarm(id: alarmId);
      return;
    }

    final int? savedHourIndex = _storage.read<int>('set_time_${alarmId}_hour');
    final int? savedMinuteIndex = _storage.read<int>(
      'set_time_${alarmId}_minute',
    );
    final int? savedPeriodIndex = _storage.read<int>(
      'set_time_${alarmId}_period',
    );

    if (savedHourIndex == null ||
        savedMinuteIndex == null ||
        savedPeriodIndex == null) {
      return;
    }

    final int hour = savedHourIndex + 1;
    final bool isPm = savedPeriodIndex == 1;
    final int selectedHour = hour == 12
        ? (isPm ? 12 : 0)
        : (isPm ? hour + 12 : hour);

    await AlarmNotificationService.instance.scheduleDailyAlarm(
      id: alarmId,
      title: title,
      body: 'Time for ${title.toLowerCase()}.',
      time: TimeOfDay(hour: selectedHour, minute: savedMinuteIndex),
    );
  }
}
