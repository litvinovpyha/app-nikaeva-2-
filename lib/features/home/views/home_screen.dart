import 'package:app/constants.dart';
import 'package:app/core/bloc/generic_bloc.dart';
import 'package:app/core/bloc/generic_event.dart';
import 'package:app/core/bloc/generic_state.dart';
import 'package:app/features/booking/model/booking.dart';
import 'package:app/features/booking/views/booking_screen.dart';
import 'package:app/features/home/views/components/actions_sheet.dart';
import 'package:app/features/home/views/components/schedule_item.dart';
import 'package:app/features/home/views/components/week_selector.dart';
import 'package:app/shared/dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,

        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                WeekSelector(
                  onDateSelected: (date) {
                    setState(() {
                      selectedDate = date;
                    });

                    context.read<GenericBloc<Booking>>().add(
                      LoadItemsByDate(date),
                    );
                  },
                ),

                const SizedBox(height: 16),

                Expanded(child: buildBookingsList()),
              ],
            ),

            Positioned(
              bottom: 120,
              right: 32,
              child: FloatingActionButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Dimens.radius10),
                ),
                backgroundColor: backgroundColor2.withValues(alpha: 0.8),
                elevation: Dimens.elevation006,
                child: const Icon(Icons.add, color: backgroundColorLight),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (context) {
                      return const FractionallySizedBox(
                        heightFactor: 0.3,
                        child: ActionsSheet(),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildBookingsList() {
  return BlocBuilder<GenericBloc<Booking>, GenericState<Booking>>(
    builder: (context, state) {
      if (state is ItemsLoading<Booking>) {
        return const Center(child: CircularProgressIndicator());
      }

      if (state is ItemsError<Booking>) {
        return Center(child: Text('Ошибка: ${state.message}'));
      }

      if (state is ItemsLoaded<Booking>) {
        final bookings = state.items;

        if (bookings.isEmpty) {
          return const Center(child: Text('Нет записей'));
        }
        final sortedBookings = [...bookings]
          ..sort((a, b) => a.date.compareTo(b.date));
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView.builder(
            itemCount: sortedBookings.length,
            itemBuilder: (context, index) {
              final Booking booking = sortedBookings[index];
              return ScheduleItem(
                time: DateFormat('HH:mm').format(booking.date.toUtc()),
                title: booking.servicesNames!.first,
                clientName: booking.clientName!,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          BookingScreen(bookingId: booking.id),
                    ),
                  );
                },
              );
            },
          ),
        );
      }

      return const SizedBox();
    },
  );
}
