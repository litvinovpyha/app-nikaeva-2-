import 'package:flutter/material.dart';

class EditBirthdayScreen extends StatefulWidget {
  const EditBirthdayScreen({super.key});

  @override
  State<EditBirthdayScreen> createState() => _EditBirthdayScreenState();
}

class _EditBirthdayScreenState extends State<EditBirthdayScreen> {
  DateTime? selectedDate;

  Future<void> pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("День рождения"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// Кнопка выбора даты
            GestureDetector(
              onTap: pickDate,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  selectedDate != null
                      ? "${selectedDate!.day}.${selectedDate!.month}.${selectedDate!.year}"
                      : "Выбрать дату",
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// Сохранить
            ElevatedButton(
              onPressed: selectedDate == null
                  ? null
                  : () {
                      Navigator.pop(context, selectedDate);
                    },
              child: const Text("Сохранить"),
            ),
          ],
        ),
      ),
    );
  }
}