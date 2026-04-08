class AffirmationModel {
  final int id;
  final String text;
  final String? authorOrSource;
  final int? category;
  final String? audioFile;
  final bool isFavorited;
  final String? shareText;

  AffirmationModel({
    required this.id,
    required this.text,
    this.authorOrSource,
    this.category,
    this.audioFile,
    required this.isFavorited,
    this.shareText,
  });

  factory AffirmationModel.fromJson(Map<String, dynamic> json) {
    return AffirmationModel(
      id: json['id'] ?? 0,
      text: json['text'] ?? "",
      authorOrSource: json['author_or_source'],
      category: json['category'],
      audioFile: json['audio_file'],
      isFavorited: json['is_favorited'] ?? false,
      shareText: json['share_text'],
    );
  }
}