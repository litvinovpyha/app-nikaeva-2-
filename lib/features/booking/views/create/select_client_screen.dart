import 'package:app/features/calculator/views/select_calculator_screen.dart';
import 'package:app/features/clients/views/client_screen.dart';
import 'package:app/features/userservice/views/select_service_screen.dart';
import 'package:flutter/material.dart';

class SelectClientScreen extends StatelessWidget {
  final bool openCalculator;

  const SelectClientScreen({super.key, this.openCalculator = false});

  @override
  Widget build(BuildContext context) {
    return ClientScreen(
      onClientTap: (client) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => openCalculator
                ? SelectCalculatorScreen(client: client)
                : SelectServiceScreen(client: client),
          ),
        );
      },
    );
  }
}
