class Ticket {
  final String name;
  final int id;

  String floor;
  String area;

  Ticket(
      {required this.name, required this.id, this.floor = "", this.area = ""});

  toMap() {
    return {'name': name, 'id': id, 'floor': floor, 'area': area};
  }
}
