class MusicModel {
  final String id;
  final String title;
  final String subtitle;
  final String duration;
  final String audioUrl;
  final String imageUrl;

  MusicModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.duration,
    required this.audioUrl,
    required this.imageUrl,
  });

  factory MusicModel.fromJson(Map<String, dynamic> json) {
    return MusicModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      subtitle: json['subtitle'] ?? '',
      duration: json['duration'] ?? '',
      audioUrl: json['audioUrl'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
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
    };
  }
}
