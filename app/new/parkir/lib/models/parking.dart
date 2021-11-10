class Parking {
  final Map parking;
  late String id;
  late String name;
  late String category;
  late String address;
  late String call;
  late String thumbnail;
  late String url;
  late String map;
  late Map rates;
  late Map hours;
  late List days;
  late Map coordinates;
  late List photos;
  late Map times;
  late bool verified;

  Parking({required this.parking}) {
    id = parking['id'];
    name = parking['name'];
    category = parking['category'];
    address = parking['address'];
    call = parking['call'];
    url = parking['url'];
    map = parking['map'];
    rates = parking['rates'];
    thumbnail = parking['thumbnail'];
    hours = parking['hours'];
    days = parking['days'];
    coordinates = parking['coordinates'];
    photos = parking['photos'];
    times = parking['times'];
    verified = parking['verified'];
  }
}
