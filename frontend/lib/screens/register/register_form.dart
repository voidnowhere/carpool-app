import 'package:carpool/services/api_service.dart';
import 'package:carpool/services/custom_snackbar.dart';
import 'package:flutter/material.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final _NameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final Map<String, String> errors = {
    'name': '',
    'email': '',
    'password': '',
  };
  void _register() {
    ApiService.register(
      name: _NameController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    ).then((value) {
      CustomSnackbar.get('Registered successfully', 17);
      Navigator.pop(context);
    }).catchError((error) {
      // Traiter les erreurs ici
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key:
          _formKey, //comme la validation des champs, la soumission du formulaire, la réinitialisation des champs, etc.
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          // C'est le widget unique que vous souhaitez envelopper avec l'espacement défini
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _NameController,
              decoration: InputDecoration(labelText: 'Name'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
            ),
            SizedBox(height: 16.0),
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
                  _register();
                  Navigator.pushNamed(context, 'login');
                }
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
