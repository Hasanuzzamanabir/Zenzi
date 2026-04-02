import 'package:dio/dio.dart';
import 'package:zenzi/core/error/api_error_handle.dart';

class ApiServices {
  final Dio dio = Dio();

  Future<Response> post(String path, {dynamic data}) async {
    try {
      return await dio.post(path, data: data);
    } catch (e) {
      throw ApiErrorHandle.handleError(e);
    }
  }
}
