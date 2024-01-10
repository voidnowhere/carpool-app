class Rating {
  int stars;

  Rating({required this.stars});

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      stars: json['value'] as int,
    );
  }
}
