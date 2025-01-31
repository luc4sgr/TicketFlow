import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:ticket_flow/models/ticket.dart';

class TicketService {
  Future<List<Ticket>> fetchTicket() async {
    await Future.delayed(const Duration(seconds: 2));
    //Carrega Json local como mock
    final String response =
        await rootBundle.loadString('assets/mocks/tickets.json');
    final List<dynamic> data = jsonDecode(response);

    return data.map((e) => Ticket.fromJson(e)).toList();
  }
}
