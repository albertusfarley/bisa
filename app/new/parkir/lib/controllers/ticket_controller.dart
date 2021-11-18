import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:parkir/models/ticket.dart';

class TicketController extends GetxController {
  final box = GetStorage();
  Rx<Ticket?> data = Rx<Ticket?>(null);

  getTicket() {
    Map map = box.read('ticket') ?? {};
    if (map.isEmpty) {
      return null;
    } else {
      data.value = Ticket(
          name: map['name'],
          id: map['id'],
          floor: map['floor'],
          area: map['area']);
    }
  }

  setTicket({required Ticket ticket}) {
    data.value = ticket;
    box.write('ticket', ticket.toMap());
  }

  deleteTicket() {
    data.value = null;
    box.remove('ticket');
  }
}
