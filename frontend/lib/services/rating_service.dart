import 'package:carpool/models/user.dart';
import 'package:carpool/services/api_service.dart';
import 'package:dio/dio.dart';

class RatingService {
  RatingService._();

  static Future<int> getRating(String id) async {
    final response = await ApiService.instance.get('/ratings/users/$id');
    return response.data as int;
  }

  static Future<User> getUser(String id) async {
    final response = await ApiService.instance.get('/users/$id');
    return User.fromJson(response.data);
  }

  static Future<dynamic> updateRating(int rateValue, String driverId) async {
    final response = await ApiService.instance
        .patch('/ratings', data: {'value': rateValue, 'ratedId': driverId});
    return response;
  }
}
