import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TicketListScreen extends StatelessWidget {
  const TicketListScreen({super.key});
  @override
  Widget build(BuildContext contex) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Tickets'),
      ),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Ticket ${index + 1}'),
            subtitle: const Text('Ticket description'),
            onTap: () => context.go('/tickets/$index'),
          );
        },
      ),
    );
  }
}
