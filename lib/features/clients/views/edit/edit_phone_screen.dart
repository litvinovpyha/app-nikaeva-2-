import 'package:flutter/material.dart';

class EditPhoneScreen extends StatefulWidget {
  final String? initialValue;

  const EditPhoneScreen({super.key, this.initialValue});

  @override
  State<EditPhoneScreen> createState() => _EditPhoneScreenState();
}

class _EditPhoneScreenState extends State<EditPhoneScreen> {
  late TextEditingController _controller;
  String? error;

  @override
  void initState() {
    super.initState();
    final initial = widget.initialValue ?? "";

    _controller = TextEditingController(
      text: initial.isNotEmpty && !initial.startsWith('+7')
          ? '$initial'
          : initial,
    );
  }

  void validateAndSave() {
    final text = _controller.text.trim();

    if (text.isEmpty) {
      setState(() => error = "Введите номер");
      return;
    }

    // убираем всё кроме цифр и +
    String cleaned = text.replaceAll(RegExp(r'[^\d+]'), '');

    String normalized;

    if (cleaned.startsWith('+7')) {
      // уже норм
      normalized = cleaned;
    } else if (cleaned.startsWith('8')) {
      // 8XXXXXXXXXX -> +7XXXXXXXXXX
      normalized = '+7${cleaned.substring(1)}';
    } else if (cleaned.length == 10) {
      // 7775551122 -> +77775551122
      normalized = '+7$cleaned';
    } else if (cleaned.length == 11 && cleaned.startsWith('7')) {
      // 777... -> +7...
      normalized = '+$cleaned';
    } else {
      setState(() => error = "Неверный формат номера");
      return;
    }

    Navigator.pop(context, normalized);
  }

  @override
  Widget build(BuildContext context) {
    final isValid = _controller.text.isNotEmpty;

    return Scaffold(
      appBar: AppBar(title: const Text("Мобильный / WhatsApp")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: "+7 формат",
                errorText: error,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: isValid ? validateAndSave : null,
              child: const Text("Сохранить"),
            ),
          ],
        ),
      ),
    );
  }
}
