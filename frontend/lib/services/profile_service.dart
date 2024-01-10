import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileService {
  static Dio? _instance;

  ProfileService._();

  static Dio get instance {
    _instance ??= Dio(
      BaseOptions(
        baseUrl: 'http://localhost:8080/api',
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

  static Future<Response> getProfile() async {
    try {
      Response response = await instance.get('/profile');
      print("response is : " + response.toString());
      return response;
    } catch (e) {
      throw Exception(('Failed to get profile : $e'));
    }
  }

  static Future<Response> updateProfile({
    required String name,
    required String email,
  }) async {
    try {
      Map<String, dynamic> data = {
        'name': name,
        'email': email,
      };
      Response response = await instance.patch(
        '/profile',
        data: data,
      );

      return response;
    } catch (e) {
      throw Exception(('Failed to update profile : $e'));
    }
  }
}
