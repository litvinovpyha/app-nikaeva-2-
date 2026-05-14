import 'package:app/features/booking/views/create/select_client_screen.dart';
import 'package:app/features/home/views/components/action_item.dart';
import 'package:flutter/material.dart';

class ActionsSheet extends StatelessWidget {
  const ActionsSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: ActionItem(
              ontap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const SelectClientScreen(openCalculator: true),
                  ),
                );
              },
              icon: Icons.payments_outlined,
              title: "Рассчитать клиента",
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ActionItem(
              ontap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const SelectClientScreen(openCalculator: false),
                  ),
                );
              },
              icon: Icons.calendar_month_outlined,
              title: "Запланировать сеанс",
            ),
          ),
        ],
      ),
    );
  }
}
