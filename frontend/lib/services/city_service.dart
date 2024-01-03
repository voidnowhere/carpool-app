import 'package:carpool/models/city.dart';
import 'package:carpool/services/api_service.dart';

class CityService {
  CityService._();

  static Future<List<City>> getAll() async {
    final response = await ApiService.instance.get('/cities');
    return (response.data as List).map((e) => City.fromJson(e)).toList();
  }
}
