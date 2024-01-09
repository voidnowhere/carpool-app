class Rating {
  int id;
  int stars;
  


  Trip({
    this.id = 0,
    required this.dateTime,
    required this.seats,
    required this.departure,
    required this.arrival,
    this.joined = false,
    this.owner = false,
  });