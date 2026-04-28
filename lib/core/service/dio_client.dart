import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class NetworkService {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://rickandmortyapi.com/',
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
    ),
  )..interceptors.add(LogInterceptor(responseBody: true));
}
