import 'package:flutter/material.dart';

class CreateUserServiceScreen extends StatefulWidget {
  final String? initialValue;

  const CreateUserServiceScreen({super.key, this.initialValue});

  @override
  State<CreateUserServiceScreen> createState() =>
      _CreateUserServiceScreenState();
}

class _CreateUserServiceScreenState extends State<CreateUserServiceScreen> {
  late TextEditingController _controller;
  String? error;

  @override
  void initState() {
    super.initState();

    _controller = TextEditingController(text: widget.initialValue ?? "");
    _controller.addListener(_onChanged);
  }

  void _onChanged() {
    final text = _controller.text.trim();

    if (text.isEmpty) {
      setState(() => error = null);
      return;
    }

    final isValid = RegExp(r"^[a-zA-Zа-яА-ЯёЁ\s]{2,50}$").hasMatch(text);

    setState(() {
      error = isValid ? null : "Только буквы и пробелы";
    });
  }

  void validateAndSave() {
    final text = _controller.text.trim();

    if (text.isEmpty) {
      setState(() => error = "Введите Название сервиса");
      return;
    }

    final isValid = RegExp(r"^[a-zA-Zа-яА-ЯёЁ\s]{2,50}$").hasMatch(text);

    if (!isValid) {
      setState(() => error = "Некорректное Название сервиса");
      return;
    }

    Navigator.pop(context, text);
  }

  @override
  Widget build(BuildContext context) {
    final isValid = error == null && _controller.text.trim().isNotEmpty;

    return Scaffold(
      appBar: AppBar(title: const Text("Название сервиса")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              keyboardType: TextInputType.name,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                labelText: "Название сервиса",
                hintText: "Например: Окрашивание",
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
