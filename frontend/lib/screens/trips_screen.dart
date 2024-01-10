import 'package:carpool/dialogs/add_trip_modal.dart';
import 'package:carpool/models/city.dart';
import 'package:carpool/models/trip.dart';
import 'package:carpool/screens/message_screen.dart';
import 'package:carpool/screens/rate_user_screen.dart';
import 'package:carpool/services/auth_service.dart';
import 'package:carpool/services/city_service.dart';
import 'package:carpool/services/trip_service.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

class TripsScreen extends StatefulWidget {
  const TripsScreen({super.key});

  @override
  State<TripsScreen> createState() => _TripsScreenState();
}

class _TripsScreenState extends State<TripsScreen> {
  final _dateTimeController = TextEditingController();
  List<City> _cities = [];
  City? _departureCity;
  City? _arrivalCity;
  List<Trip> _trips = [];

  @override
  void initState() {
    super.initState();

    CityService.getAll().then((value) {
      setState(() {
        _cities = value;
      });
    });
  }

  void _getTrips() {
    TripService.getAll(
      DateTime.parse(_dateTimeController.text),
      _departureCity!,
      _arrivalCity!,
    ).then((value) {
      setState(() {
        _trips = value;
      });
    });
  }

  void _joinTrip(int tripId) {
    TripService.join(tripId).then((value) {
      _getTrips();
    });
  }

  void _leaveTrip(int tripId) {
    TripService.leave(tripId).then((value) {
      _getTrips();
    });
  }

  void _showAddTripDialog() {
    showDialog(
      context: context,
      builder: (context) => AddTripDialog(cities: _cities),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trips'),
        actions: [
          PopupMenuButton(
            offset: const Offset(0, 50),
            icon: const Icon(
              Icons.menu,
            ),
            onSelected: (value) {
              // Profile
              if (value == 0) {
                Navigator.pushNamed(context, 'profile');
              }
              // Password
              else if (value == 1) {
                AuthService.logout(context);
              }
            },
            itemBuilder: (context) => const [
              PopupMenuItem(
                  value: 0,
                  child: Row(
                    children: [
                      Icon(Icons.account_circle),
                      SizedBox(width: 5),
                      Text('Profile'),
                    ],
                  )),
              PopupMenuItem(
                  value: 1,
                  child: Row(
                    children: [
                      Icon(Icons.logout),
                      SizedBox(width: 5),
                      Text('Logout'),
                    ],
                  )),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTripDialog,
        child: const Icon(Icons.add),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              controller: _dateTimeController,
              keyboardType: TextInputType.datetime,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'DateTime',
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Departure'),
                const SizedBox(width: 10),
                DropdownButton(
                  value: _departureCity,
                  items: _cities
                      .map((c) =>
                          DropdownMenuItem(value: c, child: Text(c.name)))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _departureCity = value;
                    });
                  },
                ),
                const SizedBox(width: 25),
                const Text('Arrival'),
                const SizedBox(width: 10),
                DropdownButton(
                  value: _arrivalCity,
                  items: _cities
                      .map((c) =>
                          DropdownMenuItem(value: c, child: Text(c.name)))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _arrivalCity = value;
                    });
                  },
                )
              ],
            ),
            ElevatedButton.icon(
              onPressed: _getTrips,
              icon: const Icon(Icons.search),
              label: const Text('Search'),
            ),
            Expanded(
              child: Scrollbar(
                child: ListView.builder(
                  itemCount: _trips.length,
                  itemBuilder: (context, index) {
                    Trip t = _trips.elementAt(index);
                    return ListTile(
                      leading: GestureDetector(
                        onTap: () {
                          if (t.joined) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    MessageScreen(tripId: t.id),
                              ),
                            );
                          }
                        },
                        child: badges.Badge(
                          badgeContent: Text(t.seats.toString()),
                          child: const Icon(Icons.people),
                        ),
                      ),
                      title: Text(t.dateTimeFormated),
                      subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${t.departure.name} to ${t.arrival.name}'),
                            (t.owner)
                                ? const Text('Yourself')
                                : ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              RateUserScreen(driver: t.driver!),
                                        ),
                                      );
                                    },
                                    child: Text(t.driver!.name),
                                  ),
                          ]),
                      isThreeLine: true,
                      trailing: (!t.owner)
                          ? (!t.joined)
                              ? ElevatedButton(
                                  onPressed: () => _joinTrip(t.id),
                                  child: const Text('join'),
                                )
                              : ElevatedButton(
                                  onPressed: () => _leaveTrip(t.id),
                                  child: const Text('leave'),
                                )
                          : null,
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
