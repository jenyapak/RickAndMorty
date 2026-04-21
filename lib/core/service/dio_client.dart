import 'package:dio/dio.dart';

class NetworkService {
  late final Dio dio;

  NetworkService() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://rickandmortyapi.com/api',
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 3),
      ),
    );

    dio.interceptors.add(LogInterceptor(responseBody: true));
  }
}
