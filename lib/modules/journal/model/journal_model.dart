class JournalModel {
  final int id;
  final String mood;
  final String note;
  final String date;

  JournalModel({
    required this.id,
    required this.mood,
    required this.note,
    required this.date,
  });

  factory JournalModel.fromMap(Map<String, dynamic> json) {
    return JournalModel(
      id: json['id'] ?? 0,
      mood: json['mood'] ?? '',
      note: json['note'] ?? '',
      date: json['date'] ?? '',
    );
  }
}
