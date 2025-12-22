import 'package:dio/dio.dart';

class HttpClient {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'https://fakestoreapi.com', contentType: 'application/json', responseType: ResponseType.json));
  Dio get client => _dio;

  HttpClient() {
    _dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
  }

  Future<T> get<T>(String path, {Map<String, dynamic>? queryParameters, Options? options}) async {
    final response = await _dio.get<T>(path, queryParameters: queryParameters, options: options);
    return response.data as T;
  }
}
