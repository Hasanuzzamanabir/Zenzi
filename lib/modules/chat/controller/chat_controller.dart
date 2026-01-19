import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  final TextEditingController messageController = TextEditingController();
  final messages = <Map<String, dynamic>>[].obs;

  void sendMessage() {
    if (messageController.text.trim().isEmpty) return;

    messages.add({"text": messageController.text.trim(), "isUser": true});

    messageController.clear();

    Future.delayed(const Duration(milliseconds: 600), () {
      messages.add({
        "text": "I’m here with you. Tell me more 🤍",
        "isUser": false,
      });
    });
  }

  @override
  void onClose() {
    messageController.dispose();
    super.onClose();
  }
}
