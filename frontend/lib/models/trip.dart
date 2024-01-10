import 'package:carpool/models/city.dart';
import 'package:carpool/models/driver.dart';
import 'package:intl/intl.dart';

class Trip {
  int id;
  DateTime dateTime;
  int seats;
  City departure;
  City arrival;
  bool joined;
  bool owner;
  Driver? driver; 
  

  Trip({
    this.id = 0,
    required this.dateTime,
    required this.seats,
    required this.departure,
    required this.arrival,
    this.joined = false,
    this.owner = false,
    this.driver,
  });

  String get dateTimeFormated {
    return DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
  }

  factory Trip.fromJson(Map<String, dynamic> json) {
    return Trip(
      id: json['id'],
      dateTime: DateTime.parse(json['dateTime']),
      seats: json['seats'],
      departure: City(
        id: json['departure']['id'],
        name: json['departure']['name'],
      ),
      arrival: City(
        id: json['arrival']['id'],
        name: json['arrival']['name'],
      ),
      joined: json['joined'],
      owner: json['owner'],
      driver: Driver(
        id: json['driver']['id'],
        name: json["driver"]['name']
        ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dateTime': dateTimeFormated,
      'seats': seats,
      'departureCityId': departure.id,
      'arrivalCityId': arrival.id,
    };
  }
}
