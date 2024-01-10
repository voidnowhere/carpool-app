import 'dart:js';

import 'package:carpool/screens/login/login_screen.dart';
import 'package:carpool/screens/profile/profile_screen.dart';
import 'package:carpool/screens/register/register_screen.dart';
import 'package:carpool/screens/trips_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'Carpool',
    initialRoute: 'login',
    routes: {
      'trips': (context) => const TripsScreen(),
      'register': (context) => const RegisterScreen(),
      'login': (context) => const LoginScreen(),
      'profile': (context) => const ProfileScreen()
    },
  ));
}