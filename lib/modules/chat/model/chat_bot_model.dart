class ChatBotModel {
  final int id;
  final String role;
  final String content;
  final String? timestamp;

  ChatBotModel({
    required this.id,
    required this.role,
    required this.content,
    this.timestamp,
  });

  factory ChatBotModel.fromJson(Map<String, dynamic> json) {
    final dynamic contentValue =
        json['content'] ?? json['message'] ?? json['text'];
    final dynamic roleValue = json['role'] ?? json['sender'] ?? json['type'];

    return ChatBotModel(
      id: json['id'] ?? 0,
      role: (roleValue ?? '').toString(),
      content: (contentValue ?? '').toString(),
      timestamp: json['timestamp']?.toString(),
    );
  }
}
