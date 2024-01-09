import 'package:carpool/screens/trips_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'Carpool',
    initialRoute: 'trips',
    routes: {
      'trips': (context) => const TripsScreen(),
    },
  ));
}