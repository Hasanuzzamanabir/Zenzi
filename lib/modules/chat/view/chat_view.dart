import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zenzi/core/theme/app_colors.dart';
import 'package:zenzi/core/widgets/themed_scaffold.dart';
import 'package:zenzi/modules/chat/controller/chat_controller.dart';

class ChatView extends GetView<ChatController> {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemedScaffold(
      appBar: AppBar(
        title: const Text(
          'Chat with Zenzi',
          style: TextStyle(
            color: AppColors.secondarycolor,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: AppColors.secondarycolor),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SafeArea(
          child: Column(
            children: [
              /// 🔹 Chat Messages
              Expanded(
                child: Obx(() {
                  if (controller.isHistoryLoading.value &&
                      controller.chatHistory.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (controller.chatHistory.isEmpty) {
                    return const Center(
                      child: Text(
                        'No chat found yet',
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                    );
                  }

                  return ListView.builder(
                    controller: controller.scrollController,
                    reverse: true,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    itemCount: controller.chatHistory.length,
                    itemBuilder: (context, index) {
                      final chat =
                          controller.chatHistory[controller.chatHistory.length -
                              1 -
                              index];
                      final bool isUser =
                          chat.role.toLowerCase().trim() == 'human';

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
                            chat.content,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              height: 1.4,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }),
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
                onSubmitted: (value) async {
                  await controller.sendMessage(value);
                },
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
            Obx(
              () => IconButton(
                onPressed: controller.isLoading.value
                    ? null
                    : () async {
                        await controller.sendMessage(
                          controller.messageController.text,
                        );
                      },
                icon: controller.isLoading.value
                    ? SizedBox(
                        width: 24.w,
                        height: 24.w,
                        child: CircularProgressIndicator(
                          color: AppColors.subscriptioncolor2,
                          strokeWidth: 2,
                        ),
                      )
                    : Icon(Icons.send),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
