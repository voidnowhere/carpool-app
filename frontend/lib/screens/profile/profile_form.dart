import 'package:carpool/services/profile_service.dart';
import 'package:flutter/material.dart';

class ProfileForm extends StatefulWidget {
  const ProfileForm({super.key});

  @override
  State<ProfileForm> createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ProfileService.getProfile().then((response) {
        final responseData = response.data as Map<String, dynamic>;
        _nameController.text = responseData['name'] ?? 'non';
        _emailController.text = responseData['email'] ?? 'non';
      }).catchError((error) {
        print("Erreur lors de la récupération du profil : ${error.toString()}");
      });
      
    });
  }

  void _update() {
    ProfileService.updateProfile(
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
    ).then((value) {
      print("Update Succesfully");
    }).catchError((error) {
      print("Erreur lors de la modification du profil : ${error.toString()}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            TextFormField(
              controller: _nameController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                label: const Text('Name'),
              ),
            ),
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                label: const Text('Email'),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                foregroundColor: Colors.white,
                shadowColor: Colors.greenAccent,
                minimumSize: Size(40, 40),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _update();
                  Navigator.pushNamed(context, 'login');
                }
              },
              child: Text('Update'),
            ),
          ],
        ),
      ),
    );
  }
}
