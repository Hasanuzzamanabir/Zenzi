class AudioTrackModel {
  final int id;
  final String title;
  final String subtitle;
  final int durationMinutes;
  final String mediaFile;
  final bool isFavorited;
  final String shareText;
  final Category category;

  AudioTrackModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.durationMinutes,
    required this.mediaFile,
    required this.isFavorited,
    required this.shareText,
    required this.category,
  });

  factory AudioTrackModel.fromJson(Map<String, dynamic> json) {
    return AudioTrackModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      subtitle: json['subtitle'] ?? '',
      durationMinutes: json['duration_minutes'] ?? 0,
      mediaFile: json['media_file'] ?? '',
      isFavorited: json['is_favorited'] ?? false,
      shareText: json['share_text'] ?? '',
      category: Category.fromJson(json['category'] ?? {}),
    );
  }
}

class Category {
  final int id;
  final String name;
  final String slug;

  Category({required this.id, required this.name, required this.slug});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      slug: json['slug'] ?? '',
    );
  }
}
