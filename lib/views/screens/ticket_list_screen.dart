// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:provider/provider.dart';
// import '../../view_models/ticket_view_model.dart';

// class TicketListScreen extends StatefulWidget {
//   const TicketListScreen({super.key});

//   @override
//   State<TicketListScreen> createState() => _TicketListScreenState();
// }

// class _TicketListScreenState extends State<TicketListScreen>
//     with AutomaticKeepAliveClientMixin {
//   @override
//   bool get wantKeepAlive => true; // Mantém o estado da tela

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       Provider.of<TicketViewModel>(context, listen: false).loadTickets();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     super.build(context);
//     final viewModel = Provider.of<TicketViewModel>(context);

//     return Scaffold(
//       appBar: AppBar(title: const Text('Lista de Tickets')),
//       body: RefreshIndicator(
//         onRefresh: () async => viewModel.loadTickets(), // Pull-to-refresh
//         child: viewModel.isLoading
//             ? const Center(child: CircularProgressIndicator())
//             : ListView.separated(
//                 padding: const EdgeInsets.all(8.0),
//                 itemCount: viewModel.tickets.length,
//                 separatorBuilder: (_, __) => const Divider(),
//                 itemBuilder: (context, index) {
//                   final ticket = viewModel.tickets[index];
//                   return Card(
//                     elevation: 2,
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10)),
//                     child: ListTile(
//                       title: Text(ticket.title,
//                           style: const TextStyle(fontWeight: FontWeight.bold)),
//                       subtitle: Text(ticket.description),
//                       trailing: Chip(label: Text(ticket.status)),
//                       onTap: () => context.go('/ticket/${ticket.id}'),
//                     ),
//                   );
//                 },
//               ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../view_models/ticket_view_model.dart';

class TicketListScreen extends StatefulWidget {
  const TicketListScreen({super.key});

  @override
  State<TicketListScreen> createState() => _TicketListScreenState();
}

class _TicketListScreenState extends State<TicketListScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TicketViewModel>(context, listen: false).loadTickets();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final viewModel = Provider.of<TicketViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Lista de Tickets')),
      body: Column(
        children: [
          // Barra de Pesquisa
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: viewModel.setSearchQuery,
              decoration: InputDecoration(
                labelText: "Buscar tickets...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          // Dropdown de Filtro
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: DropdownButton<String>(
              value: viewModel.selectedStatus,
              onChanged: (String? newValue) {
                if (newValue != null) {
                  viewModel.setStatusFilter(newValue);
                }
              },
              isExpanded: true,
              items: ["Todos", "Aberto", "Em andamento", "Fechado"]
                  .map((status) => DropdownMenuItem(
                        value: status,
                        child: Text(status),
                      ))
                  .toList(),
            ),
          ),
          const SizedBox(height: 10),
          // Lista de Tickets
          Expanded(
            child: viewModel.isLoading
                ? const Center(child: CircularProgressIndicator())
                : viewModel.tickets.isEmpty
                    ? const Center(child: Text("Nenhum ticket encontrado"))
                    : ListView.separated(
                        padding: const EdgeInsets.all(8.0),
                        itemCount: viewModel.tickets.length,
                        separatorBuilder: (_, __) => const Divider(),
                        itemBuilder: (context, index) {
                          final ticket = viewModel.tickets[index];

                          return Card(
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: ListTile(
                              title: Text(ticket.title,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                              subtitle: Text(ticket.description),
                              trailing: Chip(label: Text(ticket.status)),
                              onTap: () => context.go('/ticket/${ticket.id}'),
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
