import 'package:dio/dio.dart';
import '../core/error/failures.dart';

abstract class BaseRepository {
  Future<T> handleRequest<T>(Future<Response> request, T Function(dynamic) fromJson) async {
    try {
      final response = await request;
      return fromJson(response.data);
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }
}
