class MeditationCategoryModel {
  final int id;
  final String name;
  final String slug;

  const MeditationCategoryModel({
    required this.id,
    required this.name,
    required this.slug,
  });

  factory MeditationCategoryModel.fromJson(Map<String, dynamic> json) {
    return MeditationCategoryModel(
      id: json['id'] as int? ?? 0,
      name: (json['name'] ?? '').toString(),
      slug: (json['slug'] ?? '').toString(),
    );
  }
}

class MeditationDetailsModel {
  final int id;
  final String title;
  final String description;
  final int durationMinutes;
  final String mediaFile;
  final String thumbnailUrl;
  final bool isPremium;
  final MeditationCategoryModel? category;
  final List<String> benefits;
  final int likesCount;
  final DateTime? createdAt;
  final bool isLikedByUser;

  const MeditationDetailsModel({
    required this.id,
    required this.title,
    required this.description,
    required this.durationMinutes,
    required this.mediaFile,
    required this.thumbnailUrl,
    required this.isPremium,
    required this.category,
    required this.benefits,
    required this.likesCount,
    required this.createdAt,
    required this.isLikedByUser,
  });

  factory MeditationDetailsModel.fromJson(Map<String, dynamic> json) {
    final dynamic categoryJson = json['category'];

    return MeditationDetailsModel(
      id: json['id'] as int? ?? 0,
      title: (json['title'] ?? '').toString(),
      description: (json['description'] ?? '').toString(),
      durationMinutes: json['duration_minutes'] as int? ?? 0,
      mediaFile: (json['media_file'] ?? '').toString(),
      thumbnailUrl: (json['thumbnail_url'] ?? '').toString(),
      isPremium: json['is_premium'] as bool? ?? false,
      category: categoryJson is Map<String, dynamic>
          ? MeditationCategoryModel.fromJson(categoryJson)
          : null,
      benefits: _parseBenefits(json['benefits']),
      likesCount: json['likes_count'] as int? ?? 0,
      createdAt: DateTime.tryParse((json['created_at'] ?? '').toString()),
      isLikedByUser: json['is_liked_by_user'] as bool? ?? false,
    );
  }

  factory MeditationDetailsModel.fallback() {
    return MeditationDetailsModel(
      id: 10,
      title: 'Meditation 101',
      description:
          'This meditation is designed to gently slow your thoughts, soften tension, and bring your attention to a state of deep relaxation. Follow the breath, stay present, and let peaceful energy flow through you.',
      durationMinutes: 20,
      mediaFile: 'https://vjs.zencdn.net/v/oceans.mp4',
      thumbnailUrl:
          'https://images.unsplash.com/photo-1511293714539-df6e890251fb?auto=format&fit=crop&w=500&q=80',
      isPremium: false,
      category: const MeditationCategoryModel(
        id: 0,
        name: 'Meditation',
        slug: '',
      ),
      benefits: const <String>[
        'Reduces stress and anxiety',
        'Improves emotional well-being',
        'Enhances self-awareness',
      ],
      likesCount: 89,
      createdAt: null,
      isLikedByUser: false,
    );
  }

  String get durationLabel {
    final int safeMinutes = durationMinutes < 0 ? 0 : durationMinutes;
    return '$safeMinutes min';
  }

  String get categoryName =>
      category?.name.trim().isNotEmpty == true ? category!.name : 'Meditation';

  static List<String> _parseBenefits(dynamic benefitsJson) {
    if (benefitsJson is! List) {
      return const <String>[];
    }

    return benefitsJson
        .map((item) => item.toString().trim())
        .where((item) => item.isNotEmpty)
        .toList();
  }
}
