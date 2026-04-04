import 'package:dio/dio.dart';
import 'package:zenzi/core/base_url/base_url.dart';
import 'package:zenzi/core/token/token_storage.dart';

class AuthInterceptor extends Interceptor {
  final Dio dio;

  AuthInterceptor(this.dio);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final accessToken = await TokenStorage.getAccessToken();

    if (accessToken != null && accessToken.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }
    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      final refreshed = await refreshToken();
      if (refreshed) {
        try {
          final request = err.requestOptions;
          final accessToken = await TokenStorage.getAccessToken();

          request.headers['Authorization'] = 'Bearer $accessToken';

          final response = await dio.fetch(request);
          return handler.resolve(response);
        } catch (e) {
          return handler.next(err);
        }
      } else {
        await TokenStorage.clearTokens();
        return handler.next(err);
      }
    }
    return handler.next(err);
  }

  Future<bool> refreshToken() async {
    try {
      final refreshToken = await TokenStorage.getRefreshToken();

      if (refreshToken == null || refreshToken.isEmpty) {
        return false;
      }

      final response = await dio.post(
        '${BaseUrl.baseUrl}/api/v1/accounts/token/refresh/',
        data: {'refresh': refreshToken},
      );

      final body = response.data;
      final newRefreshToken = body['refresh'];
      final newAccessToken = body['access'];

      await TokenStorage.saveAccessToken(newAccessToken);

      if (newAccessToken != null) {
        await TokenStorage.saveRefreshToken(newRefreshToken);
      }

      return true;
    } catch (e) {
      return false;
    }
  }
}
