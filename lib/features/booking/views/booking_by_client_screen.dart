import 'package:app/core/bloc/generic_bloc.dart';
import 'package:app/core/bloc/generic_event.dart';
import 'package:app/core/bloc/generic_state.dart';
import 'package:app/features/booking/model/booking.dart';
import 'package:app/features/booking/views/booking_screen.dart';
import 'package:app/features/home/views/components/schedule_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class BookingByClientScreen extends StatefulWidget {
  final String clientId;

  const BookingByClientScreen({super.key, required this.clientId});

  @override
  State<BookingByClientScreen> createState() => _BookingByClientScreenState();
}

class _BookingByClientScreenState extends State<BookingByClientScreen> {
  @override
  void initState() {
    super.initState();

    context.read<GenericBloc<Booking>>().add(LoadItems());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Все записи')),
      body: BlocBuilder<GenericBloc<Booking>, GenericState<Booking>>(
        builder: (context, state) {
          if (state is ItemsLoading<Booking>) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is ItemsLoaded<Booking>) {
            final bookings =
                state.items.where((b) => b.clientId == widget.clientId).toList()
                  ..sort((a, b) => b.date.compareTo(a.date));

            if (bookings.isEmpty) {
              return const Center(child: Text('Нет записей клиента'));
            }

            final now = DateTime.now();

            final upcoming = bookings.where((b) => b.date.isAfter(now)).toList()
              ..sort((a, b) => a.date.compareTo(b.date));

            final past = bookings.where((b) => b.date.isBefore(now)).toList()
              ..sort((a, b) => b.date.compareTo(a.date));

            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                if (upcoming.isNotEmpty) ...[
                  const Text(
                    "Будущие",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),

                  ...upcoming.map((b) => _buildBookingTile(context, b)),

                  const SizedBox(height: 20),
                ],

                if (past.isNotEmpty) ...[
                  const Text(
                    "Прошедшие",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),

                  ...past.map((b) => _buildBookingTile(context, b)),
                ],
              ],
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}

Widget _buildBookingTile(BuildContext context, Booking booking) {
  return Container(
    margin: const EdgeInsets.only(bottom: 10),
    child: ScheduleItem(
      time: DateFormat('HH:mm').format(booking.date.toLocal()),
      title: booking.servicesNames!.first,
      clientName: booking.clientName!,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BookingScreen(bookingId: booking.id),
          ),
        );
      },
    ),
  );
}
