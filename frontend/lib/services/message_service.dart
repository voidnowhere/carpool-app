import 'package:carpool/models/message.dart';
import 'package:carpool/services/api_service.dart';
import 'package:carpool/services/auth_service.dart';
import 'package:dio/dio.dart';

class MessageService {
  MessageService._();

  static Future<List<Message>> getAll(int tripId) async {
    final response = await ApiService.instance.get(
      '/messages/trips/$tripId',
    );
    final loggedInUserId = await AuthService.userId;
    return (response.data as List)
        .map((e) => Message.fromJson(e, loggedInUserId))
        .toList();
  }

  static Future<Response> store(int tripId, String content) async {
    final response = await ApiService.instance.post(
      '/messages',
      data: {
        'message': content,
        'tripId': tripId,
      },
    );
    return response;
  }
}
