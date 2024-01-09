import 'package:dio/dio.dart';

class ApiService {
  static Dio? _instance;

  ApiService._();

  static Dio get instance {
    _instance ??= Dio(
      BaseOptions(
        baseUrl: 'http://localhost:8080/api',
        connectTimeout: const Duration(seconds: 10),
        headers: Map.from({
          'Authorization': 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIyMzk5ODIzMi04NmViLTQ2MDktYmFmMy0yMWZhMWE3MzcwMTIiLCJpYXQiOjE3MDQ3OTQ2MTIsImV4cCI6MTcwNDg4MTAxMn0.rnXi6qJb3Y8ZK_WEIRSzUbmunJSS6rTbd5vDv9vH0oE',
        })
      ),
    );  

    return _instance!;
  }
}
