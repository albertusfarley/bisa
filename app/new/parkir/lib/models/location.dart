class Location {
  final Map location;
  late String id;
  late String name;
  late String category;
  late String address;
  late String call;
  late String thumbnail;
  late String url;
  late String map;
  late double rate;
  late Map rates;
  late Map hours;
  late List days;
  late Map coordinates;
  late List photos;
  late Map times;

  Location({required this.location}) {
    id = location['id'];
    name = location['name'];
    category = location['category'];
    address = location['address'];
    call = location['call'];
    url = location['url'];
    map = location['map'];
    rate = location['rate'];
    rates = location['rates'];
    thumbnail = location['thumbnail'];
    hours = location['hours'];
    days = location['days'];
    coordinates = location['coordinates'];
    photos = location['photos'];
    times = location['times'];
  }
}
