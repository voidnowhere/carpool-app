import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class ApiService {
  static Dio? _instance;

  ApiService._();

  static void _logout(SharedPreferences prefs) {
    prefs.remove('accessToken');
    prefs.remove('refreshToken');
    // Ajoutez ici la logique pour gérer la déconnexion
  }

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
            final SharedPreferences prefs =
                await SharedPreferences.getInstance();
            final String? token = prefs.getString('token');

            if (token != null){
              options.headers['Authorization'] = token;
            }
            return handler.next(options);
          },
        ),
      );
      
    return _instance!;
  }

  static Future<Response> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      Map<String, dynamic> data = {
        'name': name,
        'email': email,
        'password': password,
      };

      Response response = await instance.post(
        '/auth/register',
        data: data,
      );

      return response;
    } catch (e) {
      throw Exception('Failed to register: $e');
    }
  }

  static Future<Response> login({
    required String email,
    required String password,
  }) async {
    try {
      Map<String, dynamic> data = {
        'email': email,
        'password': password,
      };

      Response response = await instance.post(
        '/auth/login',
        data: data,
      );

      if (response.statusCode == 200) {
        // Si la connexion réussit, récupérer le token d'accès
        Map<String, dynamic> responseData = response.data;
        String token = responseData['token'];

        // Décoder le token pour obtenir ses informations
        Map<String, dynamic> decodedToken = JwtDecoder.decode(token);

        // Sauvegarder le token d'accès dans SharedPreferences par exemple
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);

        return response;
      } else {
        throw Exception('Failed to login');
      }
    } catch (e) {
      throw Exception('Failed to login: $e');
    }
  }
}
