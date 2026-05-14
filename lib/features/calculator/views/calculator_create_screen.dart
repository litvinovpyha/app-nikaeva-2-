import 'package:app/core/bloc/generic_bloc.dart';
import 'package:app/core/bloc/generic_event.dart';
import 'package:app/features/calculator/models/calculator.dart';
import 'package:app/features/calculator/views/calculator_fields_views.dart';
import 'package:app/features/calculator/views/widgets/create_button.dart';
import 'package:app/features/calculator/views/widgets/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalculatorCreateScreen extends StatefulWidget {
  const CalculatorCreateScreen({super.key});

  @override
  State<CalculatorCreateScreen> createState() => _CalculatorCreateScreenState();
}

class _CalculatorCreateScreenState extends State<CalculatorCreateScreen> {
  final TextEditingController _controller = TextEditingController();
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _isButtonEnabled = _controller.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Создать калькулятор')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
          child: MyTextField(
            controller: _controller,
            title: 'Введите название (Например: Окрашивание)',
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: CreateButton(
          onTap: _isButtonEnabled
              ? () {
                  // создать калькулятор
                  context.read<GenericBloc<Calculator>>().add(
                    CreateItem<Calculator>(
                      Calculator(
                        id: '',
                        position: 0,
                        title: _controller.text,
                        clientId: '',
                        calculatorFields: [],
                      ),
                    ),
                  );

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CalculatorFieldsViews(),
                    ),
                  ); // Действие при нажатии
                }
              : null, // если null — кнопка неактивна
          title: 'Добавить название и продолжить',
          isEnabled: _isButtonEnabled,
        ),
      ),
    );
  }
}
