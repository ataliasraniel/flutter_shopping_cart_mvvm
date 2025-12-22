import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class HttpService {
  late final Dio _dio;
  Dio get client => _dio;

  HttpService({String? baseUrl}) {
    final apiBaseUrl = baseUrl ?? dotenv.env['API_BASE_URL'] ?? 'https://fakestoreapi.com';
    _dio = Dio(BaseOptions(baseUrl: apiBaseUrl, contentType: 'application/json'));
    _dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
  }

  Future<T> get<T>(String path, {Map<String, dynamic>? queryParameters, Options? options}) async {
    try {
      final response = await _dio.get<T>(path, queryParameters: queryParameters, options: options);
      if (response.data == null) {
        throw StateError('Received null response data for GET $path');
      }
      return response.data as T;
    } on DioException catch (e) {
      throw DioException(requestOptions: e.requestOptions, response: e.response, type: e.type, error: 'GET $path failed: ${e.message}');
    } catch (e) {
      throw DioException(
        requestOptions: RequestOptions(path: path),
        error: 'Unexpected error during GET $path: $e',
      );
    }
  }
}
