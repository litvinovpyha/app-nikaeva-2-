import 'package:flutter/material.dart';

class EditCommentScreen extends StatefulWidget {
  final String? initialValue;

  const EditCommentScreen({super.key, this.initialValue});

  @override
  State<EditCommentScreen> createState() => _EditCommentScreenState();
}

class _EditCommentScreenState extends State<EditCommentScreen> {
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
  }

  void validateAndSave() {
    final text = _controller.text.trim();

    if (text.isEmpty) {
      setState(() => error = "Введите Коммент");
      return;
    }
    Navigator.pop(context, text);
  }

  @override
  Widget build(BuildContext context) {
    final isValid = error == null && _controller.text.trim().isNotEmpty;

    return Scaffold(
      appBar: AppBar(title: const Text("Коммент")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              maxLines: null,
              controller: _controller,
              keyboardType: TextInputType.multiline,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                labelText: "Коммент",
                hintText: "Иван Иванов",
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
