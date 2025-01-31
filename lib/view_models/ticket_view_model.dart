import 'package:flutter/material.dart';
import '../services/ticket_service.dart';
import '../models/ticket.dart';

class TicketViewModel extends ChangeNotifier {
  final TicketService _ticketService = TicketService();
  List<Ticket> _tickets = [];
  bool _isLoading = false;

  List<Ticket> get tickets => _tickets;
  bool get isLoading => _isLoading;

  Future<void> loadTickets() async {
    _isLoading = true;
    notifyListeners();

    try {
      _tickets = await _ticketService.fetchTickets();
    } catch (e) {
      _tickets = [];
    }
    _isLoading = false;
    notifyListeners();
  }
}
