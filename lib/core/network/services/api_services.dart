import 'dart:io';

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

  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    bool requireAuth = true,
  }) async {
    try {
      return await dio(requireAuth).get(path, queryParameters: queryParameters);
    } on DioException catch (e) {
      throw ApiErrorHandle.handleError(e);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Response> patch(
    String path, {
    dynamic data,
    bool requireAuth = true,
  }) async {
    try {
      return await dio(requireAuth).patch(path, data: data);
    } on DioException catch (e) {
      throw ApiErrorHandle.handleError(e);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Response> delete(String path, {bool requireAuth = true}) async {
    try {
      return await dio(requireAuth).delete(path);
    } on DioException catch (e) {
      throw ApiErrorHandle.handleError(e);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  //Multipart File
  Future<MultipartFile> multipartFile(File file) async {
    return await MultipartFile.fromFile(
      file.path,
      filename: file.path.split('/').last,
    );
  }
}
