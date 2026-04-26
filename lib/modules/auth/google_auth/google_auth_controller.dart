import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:zenzi/core/network/error/get_response_message.dart';
import 'package:zenzi/core/network/services/api_services.dart';
import 'package:zenzi/core/token/token_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthController extends GetxController {
  RxBool isLoading = false.obs;

  final ApiServices apiServices = ApiServices();
  final GetResponseMessage getResponseMessage = GetResponseMessage();

  // 7.2.0 version-e constructor-ei serverClientId dewa jay
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    serverClientId:
        "367445926728-mksvkh1943ralg8944qp888emi2ces03.apps.googleusercontent.com",
  );

  Future<bool> loginWithGoogle() async {
    try {
      isLoading.value = true;

      // Previous session thakle clear kora (optional but safe)
      if (await _googleSignIn.isSignedIn()) {
        await _googleSignIn.signOut();
      }

      // Step 1: Sign in call (Native UI open hobe)
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        log('User canceled Google Sign-In');
        return false;
      }

      // Step 2: Authentication details collect kora
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final String? idToken = googleAuth.idToken;

      log('Google idToken: $idToken'); // Testing-er jonno thaklo

      if (idToken == null || idToken.isEmpty) {
        throw Exception('Google idToken not found.');
      }

      // Step 3: Backend-e POST request pathano
      final response = await apiServices.post(
        '/api/v1/accounts/google-login/',
        requireAuth: false,
        data: {'id_token': idToken},
      );

      // Step 4: Token extraction & storage
      final body = response.data;

      // Zenzi API response mapping (ensure data structure matches)
      final accessToken = body['data']?['access'];
      final refreshToken = body['data']?['refresh'];

      if (accessToken == null || refreshToken == null) {
        throw Exception('Backend theke invalid response ashche.');
      }

      // Save to secure storage
      await TokenStorage.saveAccessToken(accessToken.toString());
      await TokenStorage.saveRefreshToken(refreshToken.toString());

      final message = getResponseMessage.getResponseMessage(body);
      Get.snackbar('Success', message);

      // Success hole navigation logic (ex: Get.offAllNamed('/home'))
      return true;
    } on DioException catch (e) {
      log('Dio Error: ${e.response?.data}');
      String errorMsg = e.response?.data['message'] ?? 'Network error occurred';
      Get.snackbar('Login Failed', errorMsg);
      return false;
    } catch (e) {
      log('Fatal Error: $e');
      Get.snackbar('Error', e.toString());
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}
