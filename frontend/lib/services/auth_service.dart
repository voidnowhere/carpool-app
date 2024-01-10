import 'package:carpool/services/api_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
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

      Response response = await ApiService.instance.post(
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

      Response response = await ApiService.instance.post(
        '/auth/login',
        data: data,
      );

      // Si la connexion réussit, récupérer le token d'accès
      Map<String, dynamic> responseData = response.data;
      String token = responseData['token'];

      // Sauvegarder le token d'accès dans SharedPreferences par exemple
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);

      return response;
    } catch (e) {
      throw Exception('Failed to login: $e');
    }
  }

  static logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    Navigator.pushReplacementNamed(context, 'login');
  }

  static Future<String> get userId async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return JwtDecoder.decode(prefs.getString('token')!)['sub'];
  }
}
