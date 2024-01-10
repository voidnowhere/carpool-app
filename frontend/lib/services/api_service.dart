import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static Dio? _instance;

  ApiService._();

  static Dio get instance {
    _instance ??= Dio(
      BaseOptions(
        baseUrl: 'http://10.0.2.2:8080/api',
        connectTimeout: const Duration(seconds: 10),
      ),
    );

    _instance!.interceptors.add(
      InterceptorsWrapper(
        onRequest: (
          RequestOptions options,
          RequestInterceptorHandler handler,
        ) async {
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          final String? token = prefs.getString('token');

          if (token != null) {
            options.headers['Authorization'] = token;
          }

          return handler.next(options);
        },
      ),
    );

    return _instance!;
  }
}
