import 'package:flutter/material.dart';

class VisitsTab extends StatefulWidget {
  final String clientId;
  const VisitsTab({super.key, required this.clientId});

  @override
  State<VisitsTab> createState() => _VisitsTabState();
}

class _VisitsTabState extends State<VisitsTab> {
  DateTime _selected = DateTime.now();

  // TODO: потом получай из Bloc/Repository
  // final List<ClientVisit  > _all = [
  //   ClientVisit(
  //     id: '1',
  //     clientId: 'c1',
  //     start: DateTime.now().subtract(const Duration(days: 2, hours: 1)),
  //     serviceName: 'Окрашивание',
  //     price: 25000,
  //     comment: 'Убрать желтизну',
  //     status: VisitStatus.completed,
  //   ),
  //   ClientVisit(
  //     id: '2',
  //     clientId: 'c1',
  //     start: DateTime.now().add(const Duration(days: 1, hours: 2)),
  //     serviceName: 'Стрижка',
  //     price: 8000,
  //     comment: null,
  //     status: VisitStatus.planned,
  //   ),
  // ];

  @override
  Widget build(BuildContext context) {
    // final visits = _all
    //     .where((v) => _isSameDay(v.start, _selected))
    //     .toList()
    //   ..sort((a, b) => a.start.compareTo(b.start));

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          child: CalendarDatePicker(
            initialDate: _selected,
            firstDate: DateTime(2020),
            lastDate: DateTime(2035),
            onDateChanged: (d) => setState(() => _selected = d),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Text(
              'Визиты на ${_selected.day}.${_selected.month}.${_selected.year}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const Spacer(),
            TextButton.icon(
              onPressed: () {
                // TODO: быстро добавить визит на выбранную дату
                // show booking sheet с предзаполненной датой
              },
              icon: const Icon(Icons.add),
              label: const Text('Добавить'),
            ),
          ],
        ),
        const SizedBox(height: 8),
        // if (visits.isEmpty)
        //   const Padding(
        //     padding: EdgeInsets.only(top: 12),
        //     child: Text('Нет визитов на эту дату'),
        //   )
        // else
        //   ...visits.map((v) => VisitCard(visit: v)),
      ],
    );
  }

  // bool _isSameDay(DateTime a, DateTime b) =>
  //     a.year == b.year && a.month == b.month && a.day == b.day;
}
