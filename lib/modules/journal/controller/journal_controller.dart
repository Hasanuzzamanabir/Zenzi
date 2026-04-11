import 'package:get/get.dart';
import 'package:zenzi/core/network/services/api_services.dart';
import 'package:zenzi/modules/journal/model/journal_model.dart';

class JournalController extends GetxController {
  RxBool isLoading = false.obs;
  ApiServices apiServices = ApiServices();

  final RxList<JournalModel> journalEntries = <JournalModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchJournalEntries();
  }

  Future<bool> fetchJournalEntries() async {
    try {
      isLoading.value = true;
      final response = await apiServices.get(
        '/api/v1/activity/journal/history/',
        requireAuth: true,
      );

      final body = response.data;
      final List<dynamic> result = body['data']?['results'] ?? [];

      journalEntries.assignAll(
        result.map((entry) => JournalModel.fromMap(entry)).toList(),
      );

      return true;
    } catch (e) {
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}
