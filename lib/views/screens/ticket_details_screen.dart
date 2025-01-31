import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../view_models/ticket_view_model.dart';
import '../../models/ticket.dart';

class TicketDetailsScreen extends StatelessWidget {
  final String ticketId;

  const TicketDetailsScreen({super.key, required this.ticketId});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<TicketViewModel>(context);
    final ticket = viewModel.tickets.firstWhere(
      (ticket) => ticket.id.toString() == ticketId,
      orElse: () =>
          Ticket(id: 0, title: "Não encontrado", description: "", status: ""),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes doTicket #$ticketId'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
                //HERO não definido no componente anterior
                tag: 'ticket_$ticketId',
                child: Material(
                  color: Colors.transparent,
                  child: Text(
                    ticket.title,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ), //TODO:verificar o theme
                )),
            const SizedBox(height: 10),
            Text(ticket.description),
            const SizedBox(height: 10),
            Text(
              'Status: ${ticket.status}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
