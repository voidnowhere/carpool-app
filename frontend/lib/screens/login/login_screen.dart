import 'package:carpool/screens/login/login_form.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        actions: [
          TextButton(
            child: const Text(
              'Register',
              style: TextStyle(
                fontSize: 17,
              ),
            ),
            onPressed: () {
              Navigator.pushNamed(context, 'register');
            },
          ),
        ],
      ),
      body: const LoginForm(),
    );
  }
}
