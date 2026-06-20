import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio;
  ApiService(this._dio);

  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) async {
    return await _dio.get(path, queryParameters: queryParameters);
  }

  Future<Response> post(String path, {dynamic data}) async {
    return await _dio.post(path, data: data);
  }
}
