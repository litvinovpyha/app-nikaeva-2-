import 'package:flutter/material.dart';

class CreateClientScreen extends StatefulWidget {
  const CreateClientScreen({super.key});

  @override
  State<CreateClientScreen> createState() => _CreateClientScreenState();
}

class _CreateClientScreenState extends State<CreateClientScreen> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();

  String? error;

  void _validate() {
    final name = _nameController.text.trim();
    final phone = _phoneController.text.trim();

    if (name.isEmpty && phone.isEmpty) {
      setState(() => error = "Введите имя или телефон");
      return;
    }

    if (name.isNotEmpty) {
      final isValidName = RegExp(r"^[a-zA-Zа-яА-ЯёЁ\s]{2,50}$").hasMatch(name);
      if (!isValidName) {
        setState(() => error = "Некорректное имя");
        return;
      }
    }

    if (phone.isNotEmpty) {
      final isValidPhone = RegExp(r"^\+?[0-9]{7,15}$").hasMatch(phone);
      if (!isValidPhone) {
        setState(() => error = "Некорректный телефон");
        return;
      }
    }

    setState(() => error = null);
  }

  void _save() {
    _validate();

    if (error != null) return;

    Navigator.pop(context, {
      'name': _nameController.text.trim().isEmpty
          ? null
          : _nameController.text.trim(),
      'phone': _phoneController.text.trim().isEmpty
          ? null
          : _phoneController.text.trim(),
    });
  }

  @override
  Widget build(BuildContext context) {
    final isValid =
        (_nameController.text.trim().isNotEmpty ||
            _phoneController.text.trim().isNotEmpty) &&
        error == null;

    return Scaffold(
      appBar: AppBar(title: const Text("Создать клиента")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              onChanged: (_) => _validate(),
              decoration: InputDecoration(
                labelText: "Имя",
                hintText: "Иван Иванов",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              onChanged: (_) => _validate(),
              decoration: InputDecoration(
                labelText: "Телефон",
                hintText: "+77001234567",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 20),

            if (error != null)
              Text(error!, style: const TextStyle(color: Colors.red)),

            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: isValid ? _save : null,
              child: const Text("Сохранить"),
            ),
          ],
        ),
      ),
    );
  }
}
