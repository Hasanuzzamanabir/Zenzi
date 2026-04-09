class MeditationsModel {
  final int id;
  final String title;
  final String description;
  final int durationMinutes;
  final String thumbnailUrl;
  final bool isPremium;
  final String shareText;

  MeditationsModel({
    required this.id,
    required this.title,
    required this.description,
    required this.durationMinutes,
    required this.thumbnailUrl,
    required this.isPremium,
    required this.shareText,
  });

  factory MeditationsModel.fromJson(Map<String, dynamic> json) {
    return MeditationsModel(
      id: json['id'] as int? ?? 0,
      title: (json['title'] ?? '').toString(),
      description: (json['description'] ?? '').toString(),
      durationMinutes: json['duration_minutes'] as int? ?? 0,
      thumbnailUrl: (json['thumbnail_url'] ?? '').toString(),
      isPremium: json['is_premium'] as bool? ?? false,
      shareText: (json['share_text'] ?? '').toString(),
    );
  }

  String get durationLabel {
    final int safeMinutes = durationMinutes < 0 ? 0 : durationMinutes;
    return '$safeMinutes min';
  }
}
