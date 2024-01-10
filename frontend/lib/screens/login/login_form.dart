import 'package:carpool/services/api_service.dart';
import 'package:carpool/services/custom_snackbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginForm();
}

class _LoginForm extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _login() {
    ApiService.login(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    ).then((value) {
      Navigator.pushNamed(context, 'trips');
      
      //  Récupérer et utiliser l'access token après la connexion
      SharedPreferences.getInstance().then((prefs) {
        String? token = prefs.getString('token');
       if (token != null) {
        print('Access Token: $token');

      // Ajouter l'access token aux headers des futures requêtes API
             //ApiService.instance.options.headers['Authorization'] = token;
        }
      });
    }).catchError((error) {
      print("Erreur sur methode lgoin : " + error.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                return null;
              },
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                foregroundColor: Colors.white,
                shadowColor: Colors.greenAccent,
                minimumSize: Size(40, 40),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _login();
                }
              },
              child: Text('Sign In'),
            ),
          ],
        ),
      ),
    );
  }
}
