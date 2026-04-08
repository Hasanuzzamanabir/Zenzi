

class AffirmationModel {
  final int? id;
  final String? text;
  final String? authorOrSource;
  final int? category; 
  final String? audioFile;
  bool? isFavorited;
  final String? shareText; 

  AffirmationModel({
    this.id,
    this.text,
    this.authorOrSource,
    this.category,
    this.audioFile,
    this.isFavorited,
    this.shareText,
  });

  String get categoryName => "Strength"; 

  factory AffirmationModel.fromJson(Map<String, dynamic> json) {
    final dynamic rawId = json['id'];

    return AffirmationModel(
      id: rawId is int ? rawId : int.tryParse(rawId?.toString() ?? ''),
      text: json['text'] ?? json['affirmation'] ?? json['content'] ?? "No Text Found",
      authorOrSource: json['author_or_source'],
      category: json['category'], 
      audioFile: json['audio_file'],
      isFavorited: json['is_favorited'] ?? false,
      shareText: json['share_text'], 
    );
  }
}