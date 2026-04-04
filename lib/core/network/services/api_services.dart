import 'package:dio/dio.dart';
import 'package:zenzi/core/network/dio_client/dio_client.dart';
import 'package:zenzi/core/network/error/api_error_handle.dart';

class ApiServices {
  Dio dio(bool requireAuth) {
    return requireAuth ? DioClient.instance : DioClient.instanceWithoutAuth;
  }

  Future<Response> post(
    String path, {
    dynamic data,
    bool requireAuth = true,
  }) async {
    try {
      return await dio(requireAuth).post(path, data: data);
    } on DioException catch (e) {
      throw ApiErrorHandle.handleError(e);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
