import 'package:intl/intl.dart';

class Message {
  String content;
  DateTime dateTime;
  String userName;

  Message({
    required this.content,
    required this.dateTime,
    required this.userName,
  });

  String get dateTimeFormated {
    return DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
  }

  factory Message.fromJson(Map<String, dynamic> json, String userId) {
    return Message(
      content: json['message'],
      dateTime: DateTime.parse(json['dateTime']),
      userName:
          (json['user']['id'] == userId) ? 'You' : json['user']['name'],
    );
  }
}
