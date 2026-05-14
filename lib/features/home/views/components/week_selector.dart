import 'package:app/constants.dart';
import 'package:flutter/material.dart';

class WeekSelector extends StatefulWidget {
  final Function(DateTime)? onDateSelected;

  const WeekSelector({super.key, this.onDateSelected});

  @override
  State<WeekSelector> createState() => _WeekSelectorState();
}

class _WeekSelectorState extends State<WeekSelector> {
  late List<DateTime> weekDates;
  int selectedIndex = 0;
  late String dayOfWeek;
  late String monthAndDay;
  final days = [
    'Понедельник',
    'Вторник',
    'Среда',
    'Четверг',
    'Пятница',
    'Суббота',
    'Воскресенье',
  ];

  final months = [
    'января',
    'февраля',
    'марта',
    'апреля',
    'мая',
    'июня',
    'июля',
    'августа',
    'сентября',
    'октября',
    'ноября',
    'декабря',
  ];
  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: weekDates[selectedIndex],
      firstDate: DateTime(2020),
      lastDate: DateTime(2035),
    );

    if (picked == null) return;

    _buildWeek(picked);
  }

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();

    dayOfWeek = days[now.weekday - 1];
    monthAndDay = '${now.day} ${months[now.month - 1]}';
    weekDates = List.generate(7, (index) => now.add(Duration(days: index)));

    selectedIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    final daysShort = ['Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб', 'Вс'];

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 42),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                dayOfWeek,
                style: const TextStyle(fontSize: 18, color: Colors.grey),
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  Text(
                    monthAndDay,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.calendar_month),
                    onPressed: _pickDate,
                  ),
                  TextButton(
                    onPressed: () {
                      _buildWeek(DateTime.now());
                    },
                    child: const Text('Сегодня'),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: 90,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: weekDates.length,
            itemBuilder: (context, index) {
              final date = weekDates[index];
              final isSelected = index == selectedIndex;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = index;

                    final selectedDate = weekDates[index];

                    dayOfWeek = days[selectedDate.weekday - 1];
                    monthAndDay =
                        '${selectedDate.day} ${months[selectedDate.month - 1]}';

                    widget.onDateSelected?.call(selectedDate);
                  });
                },
                child: Container(
                  width: 60,
                  margin: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? backgroundColor2.withValues(alpha: 0.7)
                        : backgroundColor2.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        daysShort[date.weekday - 1],
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        date.day.toString(),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: isSelected ? Colors.white : Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  void _buildWeek(DateTime baseDate) {
    final startOfWeek = baseDate.subtract(Duration(days: baseDate.weekday - 1));

    setState(() {
      weekDates = List.generate(
        7,
        (index) => startOfWeek.add(Duration(days: index)),
      );

      selectedIndex = weekDates.indexWhere(
        (d) =>
            d.year == baseDate.year &&
            d.month == baseDate.month &&
            d.day == baseDate.day,
      );

      final selectedDate = baseDate;

      dayOfWeek = days[selectedDate.weekday - 1];
      monthAndDay = '${selectedDate.day} ${months[selectedDate.month - 1]}';

      widget.onDateSelected?.call(selectedDate);
    });
  }
}
