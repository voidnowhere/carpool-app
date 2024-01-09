import 'package:carpool/models/driver.dart';
import 'package:carpool/models/rating.dart';
import 'package:carpool/models/user.dart';
import 'package:carpool/services/rating_service.dart';
import 'package:flutter/material.dart';

// class RatingsScreen extends StatefulWidget{
//     const RatingsScreen({super.key});
//      @override
//   State<RatingsScreen> createState() => _RatingsScreenState();
// }

// class _RatingsScreenState extends State<RatingsScreen>{
//   Driver? _driver;
//   Rating? _rating;

//   void _getRated(){
//     RatingService.getUser(_driver!.id).then((value) {
//       setState(() {

//       });
//     });
//   }

//   void _getRating(){
//     RatingService.getRating(_driver!.id).then((value) => null)
//   }

// }
class RateUserScreen extends StatefulWidget {
  Driver driver;
  RateUserScreen({super.key, required this.driver});

  @override
  State<RateUserScreen> createState() => _RateUserScreenState();
}

class _RateUserScreenState extends State<RateUserScreen> {
  int selected_rate = 0; // Initial rating value
  Rating? _rating;
  User? _user;

  void initState() {
    super.initState();
    //get driver to display
    RatingService.getUser(widget.driver.id).then((value) {
      setState(() {
        _user = value;
      });
    });
    // get totale rating to displzy
    RatingService.getRating(widget.driver.id).then((value) {
      setState(() {
        _rating = Rating(stars: value);
      });
    });
  }

  void _updateRating(int ratingVal, String driverId) {
    RatingService.updateRating(ratingVal, driverId).then((value) {
      print(ratingVal);
    });
  }

  // void _getRated(){
  //   RatingService.getUser(_driver!.id).then((value) {
  //     setState(() {
  //       _user = value;
  //     });
  //   });
  //  }
  // void _getRating(){
  //   RatingService.getRating(_driver!.id).then((value) {
  //    setState(() {
  //      _rating!.stars = value;
  //    });
  //   });
  //  }
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
                  ? CircularProgressIndicator()
                  : const Icon(
                      Icons.account_circle,
                      color: Color.fromARGB(255, 99, 154, 249),
                      size: 150.0,
                    ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return Icon(
                    index < _rating!.stars.floor()
                        ? Icons.star
                        : Icons.star_border,
                    color: Colors.amber,
                    size: 32,
                  );
                }),
              ),
              const SizedBox(height: 20),
              TextFormField(
                initialValue: _user!.name,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                enabled: false,
                initialValue: _user!.email,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return IconButton(
                    onPressed: () {
                      setState(() {
                        selected_rate = index + 1;
                      });
                    },
                    icon: Icon(
                      index < selected_rate.floor()
                          ? Icons.star
                          : Icons.star_border,
                      color: Colors.amber,
                      size: 32,
                    ),
                  );
                }),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  _updateRating(selected_rate, widget.driver.id);
                },
                child: Text('Submit Rating'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
