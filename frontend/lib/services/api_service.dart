import 'package:dio/dio.dart';

class ApiService {
  static Dio? _instance;

  ApiService._();

  static Dio get instance {
    _instance ??= Dio(
      BaseOptions(
        baseUrl: 'http://10.0.2.2:8080/api',
        connectTimeout: const Duration(seconds: 10),
        headers: Map.from({
          'User-Id': 'c39237eb-f8f1-461d-8a3f-bd086d0189b0',
        })
      ),
    );

    return _instance!;
  }
}
