class BreathingModel {
  final int id;
  final String title;
  final String summary;
  final String iconCode;
  final int inhaleSeconds;
  final int holdSeconds;
  final int exhaleSeconds;
  final int holdOutSeconds;
  final int recommendedCycles;
  final int totalSession;

  BreathingModel({
    required this.id,
    required this.title,
    required this.summary,
    required this.iconCode,
    required this.inhaleSeconds,
    required this.holdSeconds,
    required this.exhaleSeconds,
    required this.holdOutSeconds,
    required this.recommendedCycles,
    required this.totalSession,
  });

  factory BreathingModel.fromJson(Map<String, dynamic> json) {
    return BreathingModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      summary: json['summary'] ?? '',
      iconCode: json['icon_code'] ?? '',
      inhaleSeconds: json['inhale_seconds'] ?? 0,
      holdSeconds: json['hold_in_seconds'] ?? 0,
      exhaleSeconds: json['exhale_seconds'] ?? 0,
      holdOutSeconds: json['hold_out_seconds'] ?? 0,
      recommendedCycles: json['recommended_cycles'] ?? 0,
      totalSession: json['total_session'] ?? 0,
    );
  }
}
