import 'package:go_router/go_router.dart';
import 'package:ticket_flow/views/screens/home_screen.dart';
import 'package:ticket_flow/views/screens/ticket_details_screen.dart';
import 'package:ticket_flow/views/screens/ticket_list_screen.dart';

final GoRouter router = GoRouter(initialLocation: '/', routes: [
  GoRoute(
    path: '/',
    builder: (context, state) => const HomeScreen(),
  ),
  GoRoute(
    path: 'tickets',
    builder: (context, state) => const TicketListScreen(),
  ),
  GoRoute(
      path: '/tickets/id',
      builder: (context, state) {
        final ticketId = state.pathParameters['id'];
        return TicketDetailsScreen(ticketId: ticketId!);
      }),
]);
