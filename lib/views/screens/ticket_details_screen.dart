import 'package:flutter/material.dart';

class TicketDetailsScreen extends StatelessWidget {
  final String ticketId;
  const TicketDetailsScreen({super.key, required this.ticketId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes doTicket #$ticketId'),
      ),
      body: Center(
        child: Text('Informações detalhadas do ticket #$ticketId'),
      ),
    );
  }
}
