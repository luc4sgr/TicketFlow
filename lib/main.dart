import 'package:flutter/material.dart';
import 'package:ticket_flow/core/router.dart';
import 'package:provider/provider.dart';
import 'view_models/ticket_view_model.dart';

void main() {
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => TicketViewModel()),
    ], child: const TicketFlowApp()),
  );
}

class TicketFlowApp extends StatelessWidget {
  const TicketFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "TicketFlow",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerConfig: router,
    );
  }
}
