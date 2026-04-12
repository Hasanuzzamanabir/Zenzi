class ActivityStatisticsModel {
  final List<DateTime> streakCalendarDates;
  final List<WeeklyChartItem> weeklyChart;
  final int totalMeditationSessions;
  final int totalBreathingDays;
  final StatisticsUserInfo userInfo;

  const ActivityStatisticsModel({
    required this.streakCalendarDates,
    required this.weeklyChart,
    required this.totalMeditationSessions,
    required this.totalBreathingDays,
    required this.userInfo,
  });

  factory ActivityStatisticsModel.fromJson(Map<String, dynamic> json) {
    final streakDatesRaw =
        (json['streak_calendar_dates'] as List<dynamic>? ?? <dynamic>[]);
    final weeklyChartRaw =
        (json['weekly_chart'] as List<dynamic>? ?? <dynamic>[]);

    return ActivityStatisticsModel(
      streakCalendarDates: streakDatesRaw
          .map((item) => DateTime.tryParse(item.toString()))
          .whereType<DateTime>()
          .toList(),
      weeklyChart: weeklyChartRaw
          .whereType<Map<String, dynamic>>()
          .map(WeeklyChartItem.fromJson)
          .toList(),
      totalMeditationSessions:
          (json['total_meditation_sessions'] as num?)?.toInt() ?? 0,
      totalBreathingDays: (json['total_breathing_days'] as num?)?.toInt() ?? 0,
      userInfo: StatisticsUserInfo.fromJson(
        (json['user_info'] as Map<String, dynamic>? ?? <String, dynamic>{}),
      ),
    );
  }
}

class WeeklyChartItem {
  final String day;
  final double meditation;
  final double music;
  final double breathing;

  const WeeklyChartItem({
    required this.day,
    required this.meditation,
    required this.music,
    required this.breathing,
  });

  factory WeeklyChartItem.fromJson(Map<String, dynamic> json) {
    return WeeklyChartItem(
      day: (json['day'] ?? '').toString(),
      meditation: (json['meditation'] as num?)?.toDouble() ?? 0,
      music: (json['music'] as num?)?.toDouble() ?? 0,
      breathing: (json['breathing'] as num?)?.toDouble() ?? 0,
    );
  }
}

class StatisticsUserInfo {
  final String name;
  final String avatar;
  final int totalPoints;
  final String levelTitle;

  const StatisticsUserInfo({
    required this.name,
    required this.avatar,
    required this.totalPoints,
    required this.levelTitle,
  });

  factory StatisticsUserInfo.fromJson(Map<String, dynamic> json) {
    return StatisticsUserInfo(
      name: (json['name'] ?? '').toString(),
      avatar: (json['avatar'] ?? '').toString(),
      totalPoints: (json['total_points'] as num?)?.toInt() ?? 0,
      levelTitle: (json['level_title'] ?? '').toString(),
    );
  }
}
