import 'package:flutter/material.dart';

class BookingSheet extends StatefulWidget {
  final String clientId;
  const BookingSheet({super.key, required this.clientId});

  @override
  State<BookingSheet> createState() => _BookingSheetState();
}

class _BookingSheetState extends State<BookingSheet> {
  DateTime _date = DateTime.now();
  TimeOfDay _time = TimeOfDay.now();
  String _service = 'Стрижка';
  final _priceCtrl = TextEditingController();
  final _commentCtrl = TextEditingController();

  @override
  void dispose() {
    _priceCtrl.dispose();
    _commentCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.fromLTRB(16, 8, 16, 16 + bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Новая запись', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),

          DropdownButtonFormField<String>(
            initialValue: _service,
            items: const [
              DropdownMenuItem(value: 'Стрижка', child: Text('Стрижка')),
              DropdownMenuItem(
                value: 'Окрашивание',
                child: Text('Окрашивание'),
              ),
              DropdownMenuItem(value: 'Укладка', child: Text('Укладка')),
            ],
            onChanged: (v) => setState(() => _service = v ?? _service),
            decoration: const InputDecoration(labelText: 'Услуга'),
          ),
          const SizedBox(height: 10),

          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () async {
                    final d = await showDatePicker(
                      context: context,
                      initialDate: _date,
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2035),
                    );
                    if (d != null) setState(() => _date = d);
                  },
                  icon: const Icon(Icons.calendar_month),
                  label: Text('${_date.day}.${_date.month}.${_date.year}'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () async {
                    final t = await showTimePicker(
                      context: context,
                      initialTime: _time,
                    );
                    if (t != null) setState(() => _time = t);
                  },
                  icon: const Icon(Icons.schedule),
                  label: Text(
                    '${_time.hour.toString().padLeft(2, '0')}:${_time.minute.toString().padLeft(2, '0')}',
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          TextField(
            controller: _priceCtrl,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Цена (₸)'),
          ),
          const SizedBox(height: 10),

          TextField(
            controller: _commentCtrl,
            maxLines: 3,
            decoration: const InputDecoration(labelText: 'Комментарий'),
          ),
          const SizedBox(height: 14),

          FilledButton(
            onPressed: () {
              // final start = DateTime(
              //   _date.year, _date.month, _date.day,
              //   _time.hour, _time.minute,
              // );

              // TODO: подставь свой event/репозиторий
              // context.read<VisitsBloc>().add(CreateVisit(
              //   clientId: widget.clientId,
              //   start: start,
              //   serviceName: _service,
              //   price: int.tryParse(_priceCtrl.text) ?? 0,
              //   comment: _commentCtrl.text.trim().isEmpty ? null : _commentCtrl.text.trim(),
              // ));

              Navigator.pop(context);
            },
            child: const Text('Создать запись'),
          ),
        ],
      ),
    );
  }
}
