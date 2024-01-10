import 'package:carpool/services/api_service.dart';
import 'package:dio/dio.dart';

class ProfileService {
  ProfileService._();

  static Future<Response> getProfile() async {
    Response response = await ApiService.instance.get('/profile');
    return response;
  }

  static Future<Response> updateProfile({
    required String name,
    required String email,
    required String password,
  }) async {
    Map<String, dynamic> data = {
      'name': name,
      'email': email,
      'password': password
    };
    Response response = await ApiService.instance.patch(
      '/profile',
      data: data,
    );

    return response;
  }
}
