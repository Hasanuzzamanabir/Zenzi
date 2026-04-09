class MusicModel {
  final String id;
  final String title;
  final String subtitle;
  final String duration;
  final String audioUrl;
  final String imageUrl;
  final bool isFavorited;

  MusicModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.duration,
    required this.audioUrl,
    required this.imageUrl,
    this.isFavorited = false,
  });

  MusicModel copyWith({
    String? id,
    String? title,
    String? subtitle,
    String? duration,
    String? audioUrl,
    String? imageUrl,
    bool? isFavorited,
  }) {
    return MusicModel(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      duration: duration ?? this.duration,
      audioUrl: audioUrl ?? this.audioUrl,
      imageUrl: imageUrl ?? this.imageUrl,
      isFavorited: isFavorited ?? this.isFavorited,
    );
  }

  factory MusicModel.fromJson(Map<String, dynamic> json) {
    return MusicModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      subtitle: json['subtitle'] ?? '',
      duration: json['duration'] ?? '',
      audioUrl: json['audioUrl'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      isFavorited: json['isFavorited'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'duration': duration,
      'audioUrl': audioUrl,
      'imageUrl': imageUrl,
      'isFavorited': isFavorited,
    };
  }
}
