import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/ticket.dart';

class TicketService {
  Future<List<Ticket>> fetchTickets() async {
    final prefs = await SharedPreferences.getInstance();
    final cachedData = prefs.getString('cached_tickets');

    if (cachedData != null) {
      return (jsonDecode(cachedData) as List)
          .map((e) => Ticket.fromJson(e))
          .toList();
    }

    await Future.delayed(
        const Duration(seconds: 2)); // Simula tempo de resposta
    final String response =
        await rootBundle.loadString('lib/assets/mocks/tickets.json');
    final List<dynamic> data = jsonDecode(response);

    // Salva no cache
    prefs.setString('cached_tickets', jsonEncode(data));

    return data.map((e) => Ticket.fromJson(e)).toList();
  }
}
