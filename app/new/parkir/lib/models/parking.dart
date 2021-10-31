class Parking {
  final String name;
  final String category;
  final String address;
  final String call;
  final String thumbnail;
  final String url;
  final Map hours;
  final Map days;
  final Map coordinates;

  Parking(
      {required this.name,
      required this.category,
      required this.address,
      required this.call,
      required this.thumbnail,
      required this.url,
      required this.hours,
      required this.days,
      required this.coordinates});
}
