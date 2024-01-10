import 'package:carpool/models/city.dart';
import 'package:carpool/models/trip.dart';
import 'package:carpool/services/api_service.dart';
import 'package:intl/intl.dart';

class TripService {
  TripService._();

  static Future<List<Trip>> getAll(
    DateTime dateTime,
    City departure,
    City arrival,
  ) async {
    final response = await ApiService.instance.get(
      '/trips',
      queryParameters: Map.from({
        'dateTime': DateFormat('yyyy-MM-dd HH:mm').format(dateTime),
        'departureCityId': departure.id,
        'arrivalCityId': arrival.id,
      }),
    );
    return (response.data as List).map((e) => Trip.fromJson(e)).toList();
  }

  static Future<dynamic> join(int tripId) async {
    final response = await ApiService.instance.patch('/trips/$tripId/join');
    return response;
  }

  static Future<dynamic> leave(int tripId) async {
    final response = await ApiService.instance.patch('/trips/$tripId/leave');
    return response;
  }

  static Future<dynamic> store(Trip trip) async {
    final response = await ApiService.instance.post(
      '/trips',
      data: trip.toJson(),
    );
    return response;
  }
}
