import 'dart:developer';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zenzi/core/network/services/api_services.dart';
import 'package:zenzi/modules/chat/model/chat_bot_model.dart';

class ChatController extends GetxController {
  final TextEditingController messageController = TextEditingController();

  ApiServices apiServices = ApiServices();
  RxBool isLoading = false.obs;

  final RxList<ChatBotModel> chatHistory = <ChatBotModel>[].obs;
  RxBool isHistoryLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchChatHistory();
  }

  Future<bool> sendMessage(String message) async {
    final String trimmedMessage = message.trim();
    if (trimmedMessage.isEmpty || isLoading.value) return false;
    try {
      isLoading.value = true;
      final response = await apiServices.post(
        '/api/v1/chatbot/chat/',
        requireAuth: true,
        data: {'message': trimmedMessage},
      );

      log('Chatbot Response: ${response.data}');
      messageController.clear();
      await fetchChatHistory();
      return true;
    } catch (e) {
      Get.snackbar('Error', 'Failed to send message');
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> fetchChatHistory() async {
    try {
      isHistoryLoading.value = true;

      final response = await apiServices.get(
        '/api/v1/chatbot/chat/',
        requireAuth: true,
      );

      final body = response.data;
      log('Chat History Response: $body');

      final List<dynamic> chatList = _extractChatList(body);

      chatHistory.assignAll(
        chatList
            .whereType<Map>()
            .map(
              (chat) => ChatBotModel.fromJson(Map<String, dynamic>.from(chat)),
            )
            .toList(),
      );
      return true;
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch chat history');
      return false;
    } finally {
      isHistoryLoading.value = false;
    }
  }

  List<dynamic> _extractChatList(dynamic body) {
    dynamic parsedBody = body;

    if (parsedBody is String && parsedBody.isNotEmpty) {
      try {
        parsedBody = jsonDecode(parsedBody);
      } catch (_) {
        return <dynamic>[];
      }
    }

    if (parsedBody is List) {
      return parsedBody;
    }

    if (parsedBody is Map) {
      final dynamic results = parsedBody['results'];
      if (results is List) {
        return results;
      }

      final dynamic data = parsedBody['data'];
      if (data is Map && data['results'] is List) {
        return data['results'] as List<dynamic>;
      }
    }

    return <dynamic>[];
  }

  @override
  void onClose() {
    messageController.dispose();
    super.onClose();
  }
}
