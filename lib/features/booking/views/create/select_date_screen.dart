import 'package:app/features/clients/models/client.dart';
import 'package:app/features/booking/views/booking_confirm_screen.dart';
import 'package:app/features/userservice/model/user_service.dart';
import 'package:flutter/material.dart';

class SelectDateScreen extends StatefulWidget {
  final Client client;
  final Set<UserService> services;

  const SelectDateScreen({
    super.key,
    required this.client,
    required this.services,
  });

  @override
  State<SelectDateScreen> createState() => _SelectDateScreenState();
}

class _SelectDateScreenState extends State<SelectDateScreen> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay? selectedTime;

  List<DateTime> weekDays = [];

  @override
  void initState() {
    super.initState();
    _generateWeek();
  }

  void _generateWeek() {
    final now = selectedDate;
    weekDays = List.generate(7, (i) => now.add(Duration(days: i)));
  }

  List<TimeOfDay> generateTimes(int startH, int startM, int endH, int endM) {
    List<TimeOfDay> list = [];
    DateTime start = DateTime(0, 0, 0, startH, startM);
    DateTime end = DateTime(0, 0, 0, endH, endM);

    while (start.isBefore(end) || start.isAtSameMomentAs(end)) {
      list.add(TimeOfDay(hour: start.hour, minute: start.minute));
      start = start.add(const Duration(minutes: 30));
    }

    return list;
  }

  Widget buildTimeSection(String title, List<TimeOfDay> times) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: times.map((time) {
              final isSelected = selectedTime == time;
              return GestureDetector(
                onTap: () => setState(() => selectedTime = time),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.blue),
                    color: isSelected ? Colors.blue : Colors.transparent,
                  ),
                  child: Text(
                    time.format(context),
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  void confirm() {
    if (selectedTime == null) return;

    final result = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      selectedTime!.hour,
      selectedTime!.minute,
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookingConfirmScreen(
          client: widget.client,
          services: widget.services,
          date: result,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Назначить дату')),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left),
                onPressed: () {
                  setState(() {
                    selectedDate = DateTime(
                      selectedDate.year,
                      selectedDate.month - 1,
                      selectedDate.day,
                    );
                    _generateWeek();
                  });
                },
              ),
              Text(
                '${_monthName(selectedDate.month)} ${selectedDate.year}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right),
                onPressed: () {
                  setState(() {
                    selectedDate = DateTime(
                      selectedDate.year,
                      selectedDate.month + 1,
                      selectedDate.day,
                    );
                    _generateWeek();
                  });
                },
              ),
            ],
          ),
          SizedBox(
            height: 80,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: weekDays.length,
              itemBuilder: (context, index) {
                final day = weekDays[index];
                final isSelected = day.day == selectedDate.day;

                return GestureDetector(
                  onTap: () => setState(() => selectedDate = day),
                  child: Container(
                    width: 60,
                    margin: const EdgeInsets.symmetric(horizontal: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: Colors.blue),
                      color: isSelected ? Colors.blue : Colors.transparent,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(_weekday(day.weekday)),
                        Text(
                          '${day.day}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          Expanded(
            child: ListView(
              children: [
                buildTimeSection('Утро', generateTimes(8, 0, 11, 30)),
                buildTimeSection('День', generateTimes(12, 0, 16, 30)),
                buildTimeSection('Вечер', generateTimes(17, 0, 21, 30)),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: confirm,
              child: const Text('Выбрать'),
            ),
          ),
        ],
      ),
    );
  }

  String _weekday(int day) {
    const days = ['Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб', 'Вс'];
    return days[day - 1];
  }

  String _monthName(int month) {
    const months = [
      'Январь',
      'Февраль',
      'Март',
      'Апрель',
      'Май',
      'Июнь',
      'Июль',
      'Август',
      'Сентябрь',
      'Октябрь',
      'Ноябрь',
      'Декабрь',
    ];
    return months[month - 1];
  }
}
