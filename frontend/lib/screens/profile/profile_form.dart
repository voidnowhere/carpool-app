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
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _getProfile();
  }

  void _getProfile() {
    setState(() {
      _loading = true;
    });
    ProfileService.getProfile().then((response) {
      final responseData = response.data;
      _nameController.text = responseData['name'];
      _emailController.text = responseData['email'];
      setState(() {
        _loading = false;
      });
    });
  }

  void _update() {
    setState(() {
      _loading = true;
    });
    ProfileService.updateProfile(
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    ).then((value) {
      _passwordController.clear();
      setState(() {
        _loading = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Profile updated successfully!')));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        padding: const EdgeInsets.all(15),
        child: (_loading)
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      label: Text('Name'),
                    ),
                  ),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      label: Text('Email'),
                    ),
                  ),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      label: Text('Password'),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      foregroundColor: Colors.white,
                      shadowColor: Colors.greenAccent,
                      minimumSize: const Size(40, 40),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _update();
                      }
                    },
                    child: const Text('Update'),
                  ),
                ],
              ),
      ),
    );
  }
}
