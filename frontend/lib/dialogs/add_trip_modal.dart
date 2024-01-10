import 'package:carpool/models/city.dart';
import 'package:carpool/models/trip.dart';
import 'package:carpool/services/trip_service.dart';
import 'package:flutter/material.dart';

class AddTripDialog extends StatefulWidget {
  final List<City> cities;
  const AddTripDialog({
    super.key,
    required this.cities,
    
  });

  @override
  State<AddTripDialog> createState() => _AddTripDialogState();
}

class _AddTripDialogState extends State<AddTripDialog> {
  final _dateTimeController = TextEditingController();
  final _seatsController = TextEditingController();
  City? _departureCity;
  City? _arrivalCity;  

  void _addTrip() {
    TripService.store(Trip(
      dateTime: DateTime.parse(_dateTimeController.text),
      seats: int.parse(_seatsController.text),
      departure: _departureCity!,
      arrival: _arrivalCity!,
    )).then((value) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Trip has beed added!')));
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      title: const Text('Add trip'),
      scrollable: true,
      actions: [
        IconButton(
          onPressed: _addTrip,
          icon: const Icon(Icons.add_box_outlined),
        )
      ],
      content: Column(
        children: [
          TextField(
            controller: _dateTimeController,
            keyboardType: TextInputType.datetime,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'DateTime',
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _seatsController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Seats',
            ),
          ),
          Row(
            children: [
              const Text('Departure'),
              const SizedBox(width: 10),
              DropdownButton(
                value: _departureCity,
                items: widget.cities
                    .map((c) => DropdownMenuItem(value: c, child: Text(c.name)))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _departureCity = value;
                  });
                },
              ),
            ],
          ),
          const SizedBox(width: 25),
          Row(
            children: [
              const Text('Arrival'),
              const SizedBox(width: 32),
              DropdownButton(
                value: _arrivalCity,
                items: widget.cities
                    .map((c) => DropdownMenuItem(value: c, child: Text(c.name)))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _arrivalCity = value;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
