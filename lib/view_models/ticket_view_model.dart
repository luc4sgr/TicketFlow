import 'package:flutter/material.dart';
import '../models/ticket.dart';
import '../services/ticket_service.dart';

class TicketViewModel extends ChangeNotifier {
  final TicketService _ticketService = TicketService();
  List<Ticket> _allTickets = []; // Lista completa
  List<Ticket> _filteredTickets = []; // Lista filtrada
  bool _isLoading = false;
  String _searchQuery = "";
  String _selectedStatus = "Todos";

  List<Ticket> get tickets => _filteredTickets;
  bool get isLoading => _isLoading;
  String get searchQuery => _searchQuery;
  String get selectedStatus => _selectedStatus;

  Future<void> loadTickets() async {
    _isLoading = true;
    notifyListeners();

    try {
      _allTickets = await _ticketService.fetchTickets();
      _applyFilters();
    } catch (e) {
      _allTickets = [];
      _filteredTickets = [];
    }

    _isLoading = false;
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    _applyFilters();
  }

  void setStatusFilter(String status) {
    _selectedStatus = status;
    _applyFilters();
  }

  void _applyFilters() {
    _filteredTickets = _allTickets.where((ticket) {
      final matchesQuery = _searchQuery.isEmpty ||
          ticket.title.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesStatus =
          _selectedStatus == "Todos" || ticket.status == _selectedStatus;

      return matchesQuery && matchesStatus;
    }).toList();

    notifyListeners();
  }
}
