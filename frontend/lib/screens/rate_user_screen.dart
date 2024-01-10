import 'package:carpool/models/driver.dart';
import 'package:carpool/models/rating.dart';
import 'package:carpool/models/user.dart';
import 'package:carpool/services/rating_service.dart';
import 'package:flutter/material.dart';

class RateUserScreen extends StatefulWidget {
  final Driver driver;
  const RateUserScreen({super.key, required this.driver});

  @override
  State<RateUserScreen> createState() => _RateUserScreenState();
}

class _RateUserScreenState extends State<RateUserScreen> {
  int _selectedRate = 0; // Initial rating value
  Rating? _rating;
  User? _user;

  @override
  void initState() {
    super.initState();
    //get driver to display
    RatingService.getUser(widget.driver.id).then((value) {
      setState(() {
        _user = value;
      });
    });
    RatingService.getRating(widget.driver.id).then((value) {
      setState(() {
        _rating = Rating(stars: value);
      });
    });
  }

  void _updateRating(int ratingVal, String driverId) {
    RatingService.updateRating(ratingVal, driverId).then((value) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Rated successfully!')));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rate Driver'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              (_rating == null && _user == null)
                  ? const CircularProgressIndicator()
                  : Column(
                      children: [
                        const Icon(
                          Icons.account_circle,
                          color: Color.fromARGB(255, 99, 154, 249),
                          size: 150.0,
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(5, (index) {
                            return Icon(
                              index < (_rating?.stars ?? 0)
                                  ? Icons.star
                                  : Icons.star_border,
                              color: Colors.amber,
                              size: 32,
                            );
                          }),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          enabled: false,
                          initialValue: _user?.name ?? '',
                          decoration: const InputDecoration(
                            labelText: 'Name',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          enabled: false,
                          initialValue: _user?.email ?? '',
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(5, (index) {
                            return IconButton(
                              onPressed: () {
                                setState(() {
                                  _selectedRate = index + 1;
                                });
                              },
                              icon: Icon(
                                index < _selectedRate.floor()
                                    ? Icons.star
                                    : Icons.star_border,
                                color: Colors.amber,
                                size: 32,
                              ),
                            );
                          }),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            _updateRating(_selectedRate, widget.driver.id);
                          },
                          child: const Text('Submit Rating'),
                        ),
                      ],
                    )
            ],
          ),
        ),
      ),
    );
  }
}
