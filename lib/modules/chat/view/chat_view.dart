import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zenzi/core/theme/app_colors.dart';
import 'package:zenzi/modules/chat/controller/chat_controller.dart';

class ChatView extends GetView<ChatController> {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(color: AppColors.backgroundcolor),
        child: SafeArea(
          child: Column(
            children: [
              /// 🔹 Top Bar
              _buildAppBar(),

              /// 🔹 Chat Messages
              Expanded(
                child: Obx(
                  () => ListView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    itemCount: controller.messages.length,
                    itemBuilder: (context, index) {
                      final message = controller.messages[index];
                      final bool isUser = message['isUser'];

                      return Align(
                        alignment: isUser
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 10,
                          ),
                          constraints: BoxConstraints(maxWidth: 280.w),
                          decoration: BoxDecoration(
                            color: isUser
                                ? AppColors.backgroundhorizon
                                : const Color(0xFF3B2B1F),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Text(
                            message['text'],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              height: 1.4,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),

              /// 🔹 Message Input
              _buildMessageInput(),
            ],
          ),
        ),
      ),
    );
  }

  // ===================== Widgets =====================

  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: const Icon(
              Icons.arrow_back,
              color: AppColors.secondarycolor,
              size: 18,
            ),
          ),
          SizedBox(width: 100.w),
          const Text(
            'Chat with Zenzi',
            style: TextStyle(
              color: AppColors.secondarycolor,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: AppColors.lighttext,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller.messageController,
                textInputAction: TextInputAction.send,
                onSubmitted: (_) => controller.sendMessage(),

                decoration: const InputDecoration(
                  hintText: "Type how you're feeling...",
                  hintStyle: TextStyle(
                    color: AppColors.textfieldiconcolor,
                    fontSize: 14,
                  ),

                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: controller.sendMessage,
              icon: const Icon(Icons.send),
            ),
          ],
        ),
      ),
    );
  }
}
