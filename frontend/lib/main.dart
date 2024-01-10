import 'package:carpool/screens/login/login_screen.dart';
import 'package:carpool/screens/profile/profile_screen.dart';
import 'package:carpool/screens/register/register_screen.dart';
import 'package:carpool/screens/trips_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  String initialRoute = 'login';

  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');
  if (token != null) {
    initialRoute = 'trips';
  }

  runApp(MaterialApp(
    title: 'Carpool',
    initialRoute: initialRoute,
    routes: {
      'trips': (context) => const TripsScreen(),
      'register': (context) => const RegisterScreen(),
      'login': (context) => const LoginScreen(),
      'profile': (context) => const ProfileScreen()
    },
  ));
}
