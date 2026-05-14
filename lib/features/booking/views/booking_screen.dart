import 'package:app/core/bloc/generic_bloc.dart';
import 'package:app/core/bloc/generic_event.dart';
import 'package:app/core/bloc/generic_state.dart';
import 'package:app/core/entryPoint/entry_point.dart';
import 'package:app/features/booking/model/booking.dart';
import 'package:app/features/clients/views/client_profile_screen.dart';
import 'package:app/features/clients/views/widgets/client_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookingScreen extends StatefulWidget {
  final String bookingId;
  BookingScreen({super.key, required this.bookingId});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  
  final TextEditingController priceController = TextEditingController();

  final TextEditingController commentController = TextEditingController();

  @override
  void initState() {
    super.initState();

    context.read<GenericBloc<Booking>>().add(
      LoadItemById<Booking>(widget.bookingId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Подтверждение записи')),
      body: BlocBuilder<GenericBloc<Booking>, GenericState<Booking>>(
        builder: (context, state) {
          if (state is ItemsLoading<Booking>) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ItemsLoaded<Booking>) {
            final booking = state.items.first;
            final TextEditingController priceController = TextEditingController(
              text: booking.price.toString(),
            );

            final TextEditingController commentController =
                TextEditingController(text: booking.comment ?? '');
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  ClientItem(
                    phone: booking.clientPhone ?? 'Не указан',
                    photo: 'assets/avatars/avatar.png',
                    name: booking.clientName!,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ClientProfileScreen(clientId: booking.clientId),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),
                  _card(onTap: () {}, title: booking.servicesNames!.join(', ')),
                  const SizedBox(height: 12),
                  _card(
                    onTap: () {},
                    title: 'Дата и время',
                    subtitle: formatDate(booking.date),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: priceController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Сумма оплаты',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: commentController,
                      maxLines: 3,
                      decoration: const InputDecoration(
                        labelText: 'Комментарий',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  InkWell(
                    onTap: () {
                      context.read<GenericBloc<Booking>>().add(
                        DeleteItem(booking.id),
                      );
                      Navigator.pop(context);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const ListTile(
                        title: Center(
                          child: Text(
                            'Удалить запись',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        final double price =
                            double.tryParse(priceController.text) ?? 0;
                        final comment = commentController.text;
                        context.read<GenericBloc<Booking>>().add(
                          UpdateItem<Booking>(
                            booking.copyWith(price: price, comment: comment),
                            booking.id,
                          ),
                        );
                   
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const EntryPoint(),
                          ),
                        );
                      },
                      child: const Text('Сохранить'),
                    ),
                  ),
                ],
              ),
            );
          }
          if (state is ItemsError<Booking>) {
            return Center(child: Text(state.message));
          }
          return const Center(child: Text('Нет данных'));
        },
      ),
    );
  }

  Widget _card({required Function()? onTap, required String title, subtitle}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  if (subtitle != null)
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  String formatDate(DateTime date) {
    String two(int n) => n.toString().padLeft(2, '0');

    final time = '${two(date.hour)}:${two(date.minute)}';

    final weekdays = [
      'Понедельник',
      'Вторник',
      'Среда',
      'Четверг',
      'Пятница',
      'Суббота',
      'Воскресенье',
    ];

    final weekday = weekdays[date.weekday - 1];

    return '$weekday ${two(date.day)}.${two(date.month)} $time';
  }
}
