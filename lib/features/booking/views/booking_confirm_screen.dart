import 'package:app/core/bloc/generic_bloc.dart';
import 'package:app/core/bloc/generic_event.dart';
import 'package:app/core/entryPoint/entry_point.dart';
import 'package:app/features/booking/model/booking.dart';
import 'package:app/features/clients/models/client.dart';
import 'package:app/features/userservice/model/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookingConfirmScreen extends StatefulWidget {
  final Client client;
  final Set<UserService> services;
  final DateTime date;

  const BookingConfirmScreen({
    super.key,
    required this.client,
    required this.services,
    required this.date,
  });

  @override
  State<BookingConfirmScreen> createState() => _BookingConfirmScreenState();
}

class _BookingConfirmScreenState extends State<BookingConfirmScreen> {
  final TextEditingController priceController = TextEditingController();
  final TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Подтверждение записи')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _card(
              child: ListTile(
                leading: const CircleAvatar(child: Icon(Icons.person)),
                title: Text(widget.client.name),
                subtitle: Text(widget.client.phone ?? ''),
              ),
            ),

            const SizedBox(height: 12),
            _card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Услуги',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: widget.services.map((e) {
                      return Chip(label: Text(e.name));
                    }).toList(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            _card(
              child: ListTile(
                leading: const Icon(Icons.calendar_today),
                title: const Text('Дата и время'),
                subtitle: Text(_formatDate(widget.date)),
              ),
            ),

            const SizedBox(height: 12),

            _card(
              child: TextField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Сумма оплаты',
                  border: OutlineInputBorder(),
                ),
              ),
            ),

            const SizedBox(height: 12),

            _card(
              child: TextField(
                controller: commentController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Комментарий',
                  border: OutlineInputBorder(),
                ),
              ),
            ),

            const SizedBox(height: 20),

            Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: OutlinedButton(
                  onPressed: () {},
                  child: const Text('Рассчитать'),
                ),
              ),
            ),

            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  final double price =
                      double.tryParse(priceController.text) ?? 0;
                  final comment = commentController.text;
                  context.read<GenericBloc<Booking>>().add(
                    CreateItem<Booking>(
                      Booking(
                        id: '',
                        clientId: widget.client.id,
                        serviceIds: widget.services.map((s) => s.id).toList(),
                        date: widget.date,
                        price: price,
                        comment: comment,
                      ),
                      
                    ),
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const EntryPoint()),
                  );
                },
                child: const Text('Сохранить'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _card({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(16),
      ),
      child: child,
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}.${date.month}.${date.year} '
        '${date.hour.toString().padLeft(2, '0')}:'
        '${date.minute.toString().padLeft(2, '0')}';
  }
}
