class Driver {
   String id;
  String name;

  Driver({required this.id, required this.name});

  factory Driver.fromJson(Map<String, dynamic> json) {
    return Driver(
      id: json['id'] as String,
      name: json['name'] as String,
    );
  }
}