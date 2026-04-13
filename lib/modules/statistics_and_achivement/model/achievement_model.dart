class AchievementResponse {
  final int count;
  final String? next;
  final String? previous;
  final List<AchievementItem> results;

  const AchievementResponse({
    required this.count,
    this.next,
    this.previous,
    required this.results,
  });

  factory AchievementResponse.fromJson(Map<String, dynamic> json) {
    final resultsRaw = (json['results'] as List<dynamic>? ?? <dynamic>[]);

    return AchievementResponse(
      count: (json['count'] as num?)?.toInt() ?? 0,
      next: (json['next'] as String?),
      previous: (json['previous'] as String?),
      results: resultsRaw
          .whereType<Map<String, dynamic>>()
          .map(AchievementItem.fromJson)
          .toList(),
    );
  }
}

class AchievementItem {
  final int id;
  final String name;
  final String? description;
  final String? badgeImage;
  final bool isUnlocked;

  const AchievementItem({
    required this.id,
    required this.name,
    this.description,
    this.badgeImage,
    this.isUnlocked = false,
  });

  factory AchievementItem.fromJson(Map<String, dynamic> json) {
    return AchievementItem(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: (json['name'] ?? '').toString(),
      description: (json['description'] as String?),
      badgeImage:
          (json['badge_image'] as String?) ?? (json['icon_url'] as String?),
      isUnlocked: (json['is_unlocked'] as bool?) ?? false,
    );
  }
}
