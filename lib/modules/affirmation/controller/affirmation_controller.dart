import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zenzi/core/network/services/api_services.dart';
import 'package:zenzi/modules/affirmation/model/affirmation_model.dart';
import 'package:flutter_tts/flutter_tts.dart';

class AffirmationController extends GetxController {
  final ApiServices apiServices = ApiServices();

  var isLoading = false.obs;
  var isLoadMore = false.obs;
  var hasError = false.obs;
  var hasMore = true.obs;

  var affirmationList = <AffirmationModel>[].obs;
  var currentIndex = 0.obs;
  var totalCount = 0.obs;

  int currentPage = 1;

  final ScrollController scrollController = ScrollController();

  final FlutterTts flutterTts = FlutterTts();
  final RxBool isSpeaking = false.obs;
  final RxBool isTtsAvailable = true.obs;

  Future<void> _fallbackCopyForShare(
    String shareText, {
    String? message,
  }) async {
    await Clipboard.setData(ClipboardData(text: shareText));
    Get.snackbar(
      'Share',
      message ?? 'Text copied to clipboard.',
      duration: const Duration(seconds: 2),
    );
  }

  Future<void> _launchOrCopy({
    required Uri uri,
    required String shareText,
    required String failureMessage,
  }) async {
    try {
      final launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
      if (!launched) {
        await _fallbackCopyForShare(shareText, message: failureMessage);
      }
    } catch (e) {
      log('Share launch error: $e');
      await _fallbackCopyForShare(shareText, message: failureMessage);
    }
  }

  Future<void> _openMessenger(String shareText) async {
    final messengerAppUri = Uri.parse(
      'fb-messenger://share?text=${Uri.encodeComponent(shareText)}',
    );

    try {
      final launched = await launchUrl(
        messengerAppUri,
        mode: LaunchMode.externalApplication,
      );
      if (launched) return;
    } catch (_) {
      // Fall through to web fallback below.
    }

    final messengerWebUri = Uri.https('www.messenger.com', '/');
    await _launchOrCopy(
      uri: messengerWebUri,
      shareText: shareText,
      failureMessage: 'Messenger unavailable. Text copied to clipboard.',
    );
  }

  Future<void> _showShareOptions(String shareText) async {
    await Get.bottomSheet(
      Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 8),
              Container(
                width: 42,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              const SizedBox(height: 12),
              ListTile(
                leading: const Icon(Icons.chat),
                title: const Text('WhatsApp'),
                onTap: () async {
                  Get.back();
                  final uri = Uri.https('wa.me', '/', {'text': shareText});
                  await _launchOrCopy(
                    uri: uri,
                    shareText: shareText,
                    failureMessage:
                        'WhatsApp unavailable. Text copied to clipboard.',
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.message),
                title: const Text('Messenger'),
                onTap: () async {
                  Get.back();
                  await _openMessenger(shareText);
                },
              ),
              ListTile(
                leading: const Icon(Icons.facebook),
                title: const Text('Facebook'),
                onTap: () async {
                  Get.back();
                  final uri = Uri.https(
                    'www.facebook.com',
                    '/sharer/sharer.php',
                    {'quote': shareText, 'u': 'https://zenzi.app'},
                  );
                  await _launchOrCopy(
                    uri: uri,
                    shareText: shareText,
                    failureMessage:
                        'Facebook unavailable. Text copied to clipboard.',
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.email_outlined),
                title: const Text('Email'),
                onTap: () async {
                  Get.back();
                  final uri = Uri(
                    scheme: 'mailto',
                    queryParameters: {
                      'subject': 'Daily Affirmation',
                      'body': shareText,
                    },
                  );
                  await _launchOrCopy(
                    uri: uri,
                    shareText: shareText,
                    failureMessage:
                        'Email app unavailable. Text copied to clipboard.',
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.copy),
                title: const Text('Copy'),
                onTap: () async {
                  Get.back();
                  await _fallbackCopyForShare(
                    shareText,
                    message: 'Text copied to clipboard.',
                  );
                },
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
      isScrollControlled: false,
    );
  }

  Future<bool> _runTtsCall(
    String methodName,
    Future<dynamic> Function() action,
  ) async {
    try {
      await action();
      return true;
    } on MissingPluginException {
      isTtsAvailable.value = false;
      log('TTS method not implemented on this platform: $methodName');
      return false;
    } on PlatformException catch (e) {
      log('TTS platform error on $methodName: ${e.message ?? e.code}');
      return false;
    } catch (e) {
      log('TTS unknown error on $methodName: $e');
      return false;
    }
  }

  Future<void> initTts() async {
    await _runTtsCall('setLanguage', () => flutterTts.setLanguage('en-US'));
    await _runTtsCall('setSpeechRate', () => flutterTts.setSpeechRate(0.5));
    await _runTtsCall('setPitch', () => flutterTts.setPitch(1.0));

    flutterTts.setStartHandler(() {
      isSpeaking.value = true;
    });

    flutterTts.setCompletionHandler(() {
      isSpeaking.value = false;
    });

    flutterTts.setCancelHandler(() {
      isSpeaking.value = false;
    });

    flutterTts.setErrorHandler((message) {
      isSpeaking.value = false;
      log('TTS Error: $message');
    });
  }

  @override
  void onClose() {
    if (isTtsAvailable.value) {
      _runTtsCall('stop', () => flutterTts.stop());
    }
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();
    getAffirmations();
    initTts();

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent - 200 &&
          !isLoadMore.value &&
          !isLoading.value &&
          hasMore.value) {
        getAffirmations(isPagination: true);
      }
    });
  }

  Future<void> getAffirmations({bool isPagination = false}) async {
    try {
      if (isPagination) {
        isLoadMore.value = true;
      } else {
        isLoading.value = true;
        hasError.value = false;
        currentPage = 1;
        hasMore.value = true;
        affirmationList.clear();
      }

      final response = await apiServices.get(
        '/api/v1/content/affirmations/?page=$currentPage',
        requireAuth: true,
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        final dynamic responseBody = response.data['data'];

        if (responseBody != null && responseBody['results'] != null) {
          final List rawList = responseBody['results'];
          totalCount.value = responseBody['count'] ?? 0;

          final list = rawList
              .map((json) => AffirmationModel.fromJson(json))
              .toList();

          if (isPagination) {
            affirmationList.addAll(list);
          } else {
            affirmationList.assignAll(list);
            currentIndex.value = 0;
          }

          final nextPage = responseBody['next'];
          if (nextPage == null || list.isEmpty) {
            hasMore.value = false;
          } else {
            currentPage++;
          }

          log(
            "Affirmations fetched successfully: ${affirmationList.length} items",
          );
        } else {
          hasMore.value = false;
        }
      } else {
        hasError.value = true;
        log("Failed to fetch affirmations. Status: ${response.statusCode}");
      }
    } catch (e) {
      hasError.value = true;
      log("Error fetching/mapping data: $e");
    } finally {
      isLoading.value = false;
      isLoadMore.value = false;
    }
  }

  Future<void> refreshAffirmations() async {
    currentPage = 1;
    hasMore.value = true;
    await getAffirmations();
  }

  Future<void> speakText(String text) async {
    if (!isTtsAvailable.value || text.trim().isEmpty) return;

    final didStop = await _runTtsCall('stop', () => flutterTts.stop());
    if (!didStop || !isTtsAvailable.value) return;
    await _runTtsCall('speak', () => flutterTts.speak(text));
  }

  Future<void> stopSpeaking() async {
    if (isTtsAvailable.value) {
      await _runTtsCall('stop', () => flutterTts.stop());
    }
    isSpeaking.value = false;
  }

  Future<void> toggleFavorite(int? id, int index) async {
    if (id == null || index < 0 || index >= affirmationList.length) {
      log("Favorite Error: invalid id/index. id=$id, index=$index");
      return;
    }

    bool previousStatus = affirmationList[index].isFavorited ?? false;
    final String endpoint = '/api/v1/content/affirmations/$id/favorite/';

    try {
      affirmationList[index].isFavorited = !previousStatus;
      affirmationList.refresh();

      log(
        'Favorite POST -> endpoint: $endpoint, id: $id, index: $index, previous: $previousStatus, optimistic: ${affirmationList[index].isFavorited}',
      );

      final response = await apiServices.post(
        endpoint,
        data: {},
        requireAuth: true,
      );

      log(
        'Favorite POST <- status: ${response.statusCode}, body: ${response.data}',
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        affirmationList[index].isFavorited =
            response.data['data']['is_favorited'];
        affirmationList.refresh();
        log("Favorite Status: ${affirmationList[index].isFavorited}");
      } else {
        log(
          'Favorite POST failed business check. Reverting to previous status.',
        );
        affirmationList[index].isFavorited = previousStatus;
        affirmationList.refresh();
      }
    } catch (e) {
      log("Favorite Error: $e");
      affirmationList[index].isFavorited = previousStatus;
      affirmationList.refresh();
    }
  }

  Future<void> nextAffirmation() async {
    if (currentIndex.value < affirmationList.length - 1) {
      currentIndex.value++;
      return;
    }

    if (hasMore.value && !isLoadMore.value && !isLoading.value) {
      final previousLength = affirmationList.length;
      await getAffirmations(isPagination: true);

      if (affirmationList.length > previousLength &&
          currentIndex.value < affirmationList.length - 1) {
        currentIndex.value++;
      }
    }
  }

  void previousAffirmation() {
    if (currentIndex.value > 0) {
      currentIndex.value--;
    }
  }

  //share Option
  Future<void> shareAffirmation(String text, String? author) async {
    if (text.trim().isEmpty) return;

    final shareText =
        ''' 
    "$text"

    ${author ?? "Unknown Author"}

    ''';

    await _showShareOptions(shareText.trim());
  }
}
