class ViewStatusAchievementsModel {
  final int currentSteak;
  final int totalSessions;
  final int totalMinutes;
  final String currentLevel;

  const ViewStatusAchievementsModel({
    required this.currentSteak,
    required this.totalSessions,
    required this.totalMinutes,
    required this.currentLevel,
  });

  factory ViewStatusAchievementsModel.fromJson(Map<String, dynamic> json) {
    return ViewStatusAchievementsModel(
      currentSteak: (json['current_steak'] as num?)?.toInt() ?? 0,
      totalSessions: (json['total_sessions'] as num?)?.toInt() ?? 0,
      totalMinutes: (json['total_minutes'] as num?)?.toInt() ?? 0,
      currentLevel: (json['current_level'] as String?) ?? '',
    );
  }
}
