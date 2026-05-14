import 'package:flutter/material.dart';

class EditContactsInfoScreen extends StatefulWidget {
  final String title; // Instagram / Telegram
  final String? initialValue;

  const EditContactsInfoScreen({
    super.key,
    required this.title,
    this.initialValue,
  });

  @override
  State<EditContactsInfoScreen> createState() => _EditContactsInfoScreenState();
}

class _EditContactsInfoScreenState extends State<EditContactsInfoScreen> {
  late TextEditingController _controller;
  String? error;

  @override
  void initState() {
    super.initState();

    final initial = widget.initialValue ?? "";

    _controller = TextEditingController(
      text: initial.isNotEmpty && !initial.startsWith('@')
          ? '$initial'
          : initial,
    );

    _controller.addListener(_onChanged);
  }

  void _onChanged() {
    final text = _controller.text.trim();

    if (text.isEmpty) {
      setState(() => error = null);
      return;
    }

    final username = text.startsWith('@') ? text.substring(1) : text;

    final isValid = RegExp(r'^[a-zA-Z0-9._]{1,30}$').hasMatch(username);

    setState(() {
      error = isValid ? null : "Некорректный ник";
    });
  }

  void validateAndSave() {
    final text = _controller.text.trim();

    if (text.isEmpty) {
      setState(() => error = "Введите ник");
      return;
    }

    final username = text.startsWith('@') ? text.substring(1) : text;

    final isValid = RegExp(r'^[a-zA-Z0-9._]{1,30}$').hasMatch(username);

    if (!isValid) {
      setState(() => error = "Некорректный ник");
      return;
    }

    Navigator.pop(context, username);
  }

  @override
  Widget build(BuildContext context) {
    final isValid = error == null && _controller.text.trim().isNotEmpty;

    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: "Введите ник",
                hintText: "username",
                prefixText: "@",
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
