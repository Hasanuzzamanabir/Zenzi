import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zenzi/core/theme/app_colors.dart';
import 'package:zenzi/core/services/alarm_notification_service.dart';
import 'package:zenzi/core/values/app_assets.dart';
import 'package:zenzi/core/widgets/themed_scaffold.dart';
import 'package:zenzi/modules/setting/controller/notification_controller.dart';
import 'dart:async';

class SetTimeView extends StatelessWidget {
  const SetTimeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemedScaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: AppColors.secondarycolor,
            size: 24.sp,
          ),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Set Time',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Set Meditation Time
              const _TimeSectionPicker(
                alarmId: 101,
                image: AssetImage(AppAssets.stress),
                title: 'Set Meditation Time',
              ),
              SizedBox(height: 20.h),

              // Set Sleeping time
              const _TimeSectionPicker(
                alarmId: 102,
                image: AssetImage(AppAssets.hotel),
                title: 'Set Sleeping time',
              ),
              SizedBox(height: 20.h),

              // Set breathing exercise time
              const _TimeSectionPicker(
                alarmId: 103,
                image: AssetImage(AppAssets.pulmonology),
                title: 'Set breathing exercise time',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TimeSectionPicker extends StatelessWidget {
  const _TimeSectionPicker({
    required this.alarmId,
    required this.image,
    required this.title,
  });

  final int alarmId;
  final ImageProvider image;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Image(image: image, color: Colors.white, width: 20.w, height: 20.h),
            SizedBox(width: 8.w),
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        Container(
          padding: EdgeInsets.only(left: 1.w, top: 12.h, bottom: 12.h),
          decoration: BoxDecoration(
            color: AppColors.skysunrise,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: AppColors.primarytext, width: 1),
          ),
          child: _WheelTimePicker(alarmId: alarmId, title: title),
        ),
      ],
    );
  }
}

class _WheelTimePicker extends StatefulWidget {
  const _WheelTimePicker({required this.alarmId, required this.title});

  final int alarmId;
  final String title;

  @override
  State<_WheelTimePicker> createState() => _WheelTimePickerState();
}

class _WheelTimePickerState extends State<_WheelTimePicker> {
  static const double _edgeMaskHeight = 18;
  static const Duration _autoSaveDelay = Duration(milliseconds: 600);
  final GetStorage _storage = GetStorage();

  late final FixedExtentScrollController _hourController;
  late final FixedExtentScrollController _minuteController;
  late final FixedExtentScrollController _periodController;
  Timer? _autoSaveTimer;

  int _hourIndex = 0;
  int _minuteIndex = 0;
  int _periodIndex = 0;

  final List<String> _hours = List<String>.generate(
    12,
    (index) => (index + 1).toString().padLeft(2, '0'),
  );
  final List<String> _minutes = List<String>.generate(
    60,
    (index) => index.toString().padLeft(2, '0'),
  );
  final List<String> _periods = const ['AM', 'PM'];

  @override
  void initState() {
    super.initState();
    _loadSavedTimeOrNow();

    _hourController = FixedExtentScrollController(initialItem: _hourIndex);
    _minuteController = FixedExtentScrollController(initialItem: _minuteIndex);
    _periodController = FixedExtentScrollController(initialItem: _periodIndex);
  }

  @override
  void dispose() {
    _autoSaveTimer?.cancel();
    _hourController.dispose();
    _minuteController.dispose();
    _periodController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isAlarmEnabled = _isAlarmEnabled();

    return Row(
      children: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildWheelBox(
                controller: _hourController,
                values: _hours,
                width: 52.w,
                onChanged: (index) {
                  setState(() => _hourIndex = index);
                  _queueAutoSave();
                },
              ),
              SizedBox(width: 8.w),
              Text(
                ':',
                style: TextStyle(
                  color: const Color(0xFF983500),
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 8.w),
              _buildWheelBox(
                controller: _minuteController,
                values: _minutes,
                width: 56.w,
                onChanged: (index) {
                  setState(() => _minuteIndex = index);
                  _queueAutoSave();
                },
              ),
              SizedBox(width: 12.w),
              _buildWheelBox(
                controller: _periodController,
                values: _periods,
                width: 64.w,
                onChanged: (index) {
                  setState(() => _periodIndex = index);
                  _queueAutoSave();
                },
              ),
            ],
          ),
        ),

        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: isAlarmEnabled
                ? const Color(0xFFD9F6E4)
                : const Color(0xFFFADFD8),
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Text(
            isAlarmEnabled ? 'ON' : 'OFF',
            style: TextStyle(
              color: isAlarmEnabled
                  ? const Color(0xFF1B7F46)
                  : const Color(0xFFAA3B1D),
              fontSize: 11.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),

        IconButton(
          onPressed: () => _scheduleAlarm(showFeedback: true),
          icon: Icon(
            Icons.alarm,
            color: isAlarmEnabled
                ? AppColors.backgroundhorizon
                : Colors.grey.shade400,
            size: 20.sp,
          ),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          tooltip: 'Set alarm',
        ),
      ],
    );
  }

  Future<void> _scheduleAlarm({bool showFeedback = false}) async {
    _persistSelectedTime();
    if (!_isAlarmEnabled()) {
      await AlarmNotificationService.instance.cancelAlarm(id: widget.alarmId);

      if (mounted && showFeedback) {
        Get.snackbar(
          'Notification turned off',
          'Turn on this category from Notification settings to schedule alarm.',
          snackPosition: SnackPosition.BOTTOM,
          margin: EdgeInsets.all(16.w),
          duration: const Duration(seconds: 3),
        );
      }
      return;
    }

    final TimeOfDay selectedTime = _selectedTimeOfDay();
    final bool scheduled = await AlarmNotificationService.instance
        .scheduleDailyAlarm(
          id: widget.alarmId,
          title: widget.title,
          body: 'Time for ${widget.title.toLowerCase()}.',
          time: selectedTime,
        );

    if (!scheduled) {
      if (!mounted) {
        return;
      }

      Get.snackbar(
        'Alarm unavailable',
        'Enable notification and exact alarm permission in Android settings.',
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.all(16.w),
        duration: const Duration(seconds: 3),
      );
      return;
    }

    if (!mounted || !showFeedback) {
      return;
    }

    Get.snackbar(
      'Alarm set',
      '${widget.title} at ${selectedTime.format(context)}',
      snackPosition: SnackPosition.BOTTOM,
      margin: EdgeInsets.all(16.w),
      duration: const Duration(seconds: 2),
    );
  }

  bool _isAlarmEnabled() {
    switch (widget.alarmId) {
      case NotificationController.meditateAlarmId:
        return _storage.read<bool>(NotificationController.meditateKey) ?? false;
      case NotificationController.sleepAlarmId:
        return _storage.read<bool>(NotificationController.sleepKey) ?? false;
      case NotificationController.exerciseAlarmId:
        return _storage.read<bool>(NotificationController.exerciseKey) ?? false;
      default:
        return false;
    }
  }

  void _queueAutoSave() {
    _autoSaveTimer?.cancel();
    _autoSaveTimer = Timer(_autoSaveDelay, () {
      if (!mounted) {
        return;
      }

      _persistSelectedTime();
      _scheduleAlarm();
    });
  }

  void _loadSavedTimeOrNow() {
    final int? savedHourIndex = _storage.read<int>(_hourKey);
    final int? savedMinuteIndex = _storage.read<int>(_minuteKey);
    final int? savedPeriodIndex = _storage.read<int>(_periodKey);

    if (savedHourIndex != null &&
        savedMinuteIndex != null &&
        savedPeriodIndex != null &&
        savedHourIndex >= 0 &&
        savedHourIndex < _hours.length &&
        savedMinuteIndex >= 0 &&
        savedMinuteIndex < _minutes.length &&
        savedPeriodIndex >= 0 &&
        savedPeriodIndex < _periods.length) {
      _hourIndex = savedHourIndex;
      _minuteIndex = savedMinuteIndex;
      _periodIndex = savedPeriodIndex;
      return;
    }

    final DateTime now = DateTime.now();
    final int hour = now.hour % 12 == 0 ? 12 : now.hour % 12;
    _hourIndex = hour - 1;
    _minuteIndex = now.minute;
    _periodIndex = now.hour >= 12 ? 1 : 0;
  }

  void _persistSelectedTime() {
    _storage.write(_hourKey, _hourIndex);
    _storage.write(_minuteKey, _minuteIndex);
    _storage.write(_periodKey, _periodIndex);
  }

  String get _hourKey => 'set_time_${widget.alarmId}_hour';
  String get _minuteKey => 'set_time_${widget.alarmId}_minute';
  String get _periodKey => 'set_time_${widget.alarmId}_period';

  TimeOfDay _selectedTimeOfDay() {
    final int hour = _hourIndex + 1;
    final bool isPm = _periodIndex == 1;
    final int selectedHour = hour == 12
        ? (isPm ? 12 : 0)
        : (isPm ? hour + 12 : hour);

    return TimeOfDay(hour: selectedHour, minute: _minuteIndex);
  }

  Widget _buildWheelBox({
    required FixedExtentScrollController controller,
    required List<String> values,
    required double width,
    required ValueChanged<int> onChanged,
  }) {
    return SizedBox(
      width: width,
      height: 64.h,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.r),
        child: Stack(
          children: [
            Container(color: AppColors.backgroundhorizon),
            ListWheelScrollView.useDelegate(
              controller: controller,
              itemExtent: 28.h,
              physics: const FixedExtentScrollPhysics(),
              diameterRatio: 1.4,
              useMagnifier: true,
              magnification: 1.08,
              overAndUnderCenterOpacity: 0.0,
              onSelectedItemChanged: onChanged,
              childDelegate: ListWheelChildBuilderDelegate(
                childCount: values.length,
                builder: (context, index) {
                  if (index < 0 || index >= values.length) {
                    return null;
                  }

                  return Center(
                    child: Text(
                      values[index],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  );
                },
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: _edgeMaskHeight.h,
                decoration: BoxDecoration(
                  color: AppColors.backgroundhorizon,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.r),
                    topRight: Radius.circular(8.r),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: _edgeMaskHeight.h,
                decoration: BoxDecoration(
                  color: AppColors.backgroundhorizon,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8.r),
                    bottomRight: Radius.circular(8.r),
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
