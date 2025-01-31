import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../view_models/ticket_view_model.dart';

class TicketListScreen extends StatefulWidget {
  const TicketListScreen({super.key});

  @override
  State<TicketListScreen> createState() => _TicketListScreenState();
}

class _TicketListScreenState extends State<TicketListScreen> {
  @override
  void initState() {
    super.initState();
    //TODO:verificar
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TicketViewModel>(context, listen: false).loadTickets();
    });
  }

  @override
  Widget build(BuildContext contex) {
    final viewModel = Provider.of<TicketViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Tickets'),
      ),
      body: viewModel.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: viewModel.tickets.length,
              itemBuilder: (context, index) {
                final ticket = viewModel.tickets[index];
                return ListTile(
                  title: Text(ticket.title),
                  subtitle: Text(ticket.description),
                  trailing: Text(ticket.status),
                  onTap: () => context.go('/ticket/${ticket.id}'),
                );
              },
            ),
    );
  }
}
