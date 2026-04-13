import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class AlarmNotificationService {
  AlarmNotificationService._();

  static final AlarmNotificationService instance = AlarmNotificationService._();

  static const AndroidNotificationSound _alarmSound =
      UriAndroidNotificationSound('content://settings/system/alarm_alert');

  final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static const AndroidNotificationChannel _alarmChannel =
      AndroidNotificationChannel(
        'zenzi_alarm_channel_v3',
        'Zenzi Alarms',
        description: 'Scheduled meditation, sleep, and breathing alarms.',
        importance: Importance.max,
        playSound: true,
        sound: _alarmSound,
        audioAttributesUsage: AudioAttributesUsage.alarm,
      );

  bool _initialized = false;
  Future<bool>? _initializationFuture;
  bool _notificationsGranted = true;
  bool _exactAlarmsGranted = true;
  bool _fullScreenIntentGranted = true;

  Future<bool> initialize() async {
    if (_initialized) {
      return true;
    }

    final Future<bool>? inFlight = _initializationFuture;
    if (inFlight != null) {
      return inFlight;
    }

    _initializationFuture = _performInitialize();

    try {
      return await _initializationFuture!;
    } finally {
      _initializationFuture = null;
    }
  }

  Future<bool> _performInitialize() async {
    if (_initialized) {
      return true;
    }

    try {
      tz.initializeTimeZones();
      try {
        final TimezoneInfo timeZoneInfo =
            await FlutterTimezone.getLocalTimezone();
        tz.setLocalLocation(tz.getLocation(timeZoneInfo.identifier));
      } catch (_) {
        tz.setLocalLocation(tz.getLocation('UTC'));
      }

      const AndroidInitializationSettings androidSettings =
          AndroidInitializationSettings('@mipmap/ic_launcher');
      const DarwinInitializationSettings iosSettings =
          DarwinInitializationSettings(
            requestAlertPermission: true,
            requestBadgePermission: true,
            requestSoundPermission: true,
          );
      const InitializationSettings initializationSettings =
          InitializationSettings(android: androidSettings, iOS: iosSettings);

      await _notificationsPlugin.initialize(settings: initializationSettings);

      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
          _notificationsPlugin
              .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin
              >();
      if (androidImplementation != null) {
        try {
          final bool? notificationsGranted = await androidImplementation
              .requestNotificationsPermission();
          if (notificationsGranted != null) {
            _notificationsGranted = notificationsGranted;
          }
        } on PlatformException catch (error) {
          debugPrint('Notification permission request failed: $error');
        }

        try {
          final bool? exactAlarmsGranted = await androidImplementation
              .requestExactAlarmsPermission();
          if (exactAlarmsGranted != null) {
            _exactAlarmsGranted = exactAlarmsGranted;
          }
        } on PlatformException catch (error) {
          debugPrint('Exact alarm permission request failed: $error');
        }

        try {
          final bool? fullScreenIntentGranted = await androidImplementation
              .requestFullScreenIntentPermission();
          if (fullScreenIntentGranted != null) {
            _fullScreenIntentGranted = fullScreenIntentGranted;
          }
        } on PlatformException catch (error) {
          debugPrint('Full screen intent permission request failed: $error');
        }

        await androidImplementation.createNotificationChannel(_alarmChannel);
      }

      _initialized = true;
      return true;
    } on MissingPluginException catch (error) {
      debugPrint('Local notifications plugin is not registered yet: $error');
      return false;
    }
  }

  Future<bool> scheduleDailyAlarm({
    required int id,
    required String title,
    required String body,
    required TimeOfDay time,
  }) async {
    final bool initialized = await initialize();
    if (!initialized) {
      return false;
    }

    if (!_notificationsGranted ||
        !_exactAlarmsGranted ||
        !_fullScreenIntentGranted) {
      await _refreshAndroidPermissions();
    }

    if (!_notificationsGranted) {
      debugPrint('Notifications permission is not granted.');
      return false;
    }

    final tz.TZDateTime scheduledDate = _nextInstanceOfTime(time);
    final AndroidScheduleMode scheduleMode = _exactAlarmsGranted
        ? AndroidScheduleMode.alarmClock
        : AndroidScheduleMode.inexactAllowWhileIdle;

    try {
      await _notificationsPlugin.cancel(id: id);
      await _scheduleWithMode(
        id: id,
        title: title,
        body: body,
        scheduledDate: scheduledDate,
        payload: body,
        mode: scheduleMode,
      );
      return true;
    } on PlatformException catch (error) {
      if (error.code == 'exact_alarms_not_permitted') {
        try {
          await _scheduleWithMode(
            id: id,
            title: title,
            body: body,
            scheduledDate: scheduledDate,
            payload: body,
            mode: AndroidScheduleMode.inexactAllowWhileIdle,
          );
          return true;
        } on PlatformException catch (fallbackError) {
          debugPrint('Local notifications fallback failed: $fallbackError');
          return false;
        }
      }

      debugPrint('Local notifications plugin call failed: $error');
      return false;
    } on MissingPluginException catch (error) {
      debugPrint('Local notifications plugin call failed: $error');
      return false;
    }
  }

  Future<void> cancelAlarm({required int id}) async {
    final bool initialized = await initialize();
    if (!initialized) {
      return;
    }

    try {
      await _notificationsPlugin.cancel(id: id);
    } on PlatformException catch (error) {
      debugPrint('Cancel alarm failed: $error');
    } on MissingPluginException catch (error) {
      debugPrint('Cancel alarm failed: $error');
    }
  }

  Future<void> _refreshAndroidPermissions() async {
    final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
        _notificationsPlugin
            .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin
            >();
    if (androidImplementation == null) {
      return;
    }

    try {
      final bool? notificationsGranted = await androidImplementation
          .requestNotificationsPermission();
      if (notificationsGranted != null) {
        _notificationsGranted = notificationsGranted;
      }
    } on PlatformException catch (error) {
      debugPrint('Notification permission refresh failed: $error');
    }

    try {
      final bool? exactAlarmsGranted = await androidImplementation
          .requestExactAlarmsPermission();
      if (exactAlarmsGranted != null) {
        _exactAlarmsGranted = exactAlarmsGranted;
      }
    } on PlatformException catch (error) {
      debugPrint('Exact alarm permission refresh failed: $error');
    }

    try {
      final bool? fullScreenIntentGranted = await androidImplementation
          .requestFullScreenIntentPermission();
      if (fullScreenIntentGranted != null) {
        _fullScreenIntentGranted = fullScreenIntentGranted;
      }
    } on PlatformException catch (error) {
      debugPrint('Full screen intent permission refresh failed: $error');
    }
  }

  Future<void> _scheduleWithMode({
    required int id,
    required String title,
    required String body,
    required tz.TZDateTime scheduledDate,
    required String payload,
    required AndroidScheduleMode mode,
  }) {
    return _notificationsPlugin.zonedSchedule(
      id: id,
      title: title,
      body: body,
      scheduledDate: scheduledDate,
      notificationDetails: NotificationDetails(
        android: AndroidNotificationDetails(
          'zenzi_alarm_channel_v3',
          'Zenzi Alarms',
          channelDescription:
              'Scheduled meditation, sleep, and breathing alarms.',
          importance: Importance.max,
          priority: Priority.high,
          playSound: true,
          sound: _alarmSound,
          enableVibration: true,
          autoCancel: false,
          ongoing: true,
          category: AndroidNotificationCategory.alarm,
          fullScreenIntent: true,
          audioAttributesUsage: AudioAttributesUsage.alarm,
          additionalFlags: Int32List.fromList(<int>[4]),
          actions: <AndroidNotificationAction>[
            AndroidNotificationAction(
              'stop_alarm',
              'Stop Alarm',
              cancelNotification: true,
              showsUserInterface: true,
            ),
          ],
        ),
        iOS: const DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
      androidScheduleMode: mode,
      matchDateTimeComponents: DateTimeComponents.time,
      payload: payload,
    );
  }

  tz.TZDateTime _nextInstanceOfTime(TimeOfDay time) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
    );

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    return scheduledDate;
  }
}
