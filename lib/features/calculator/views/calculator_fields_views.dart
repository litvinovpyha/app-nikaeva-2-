import 'package:app/features/calculator/views/widgets/calculator_field_list.dart';
import 'package:app/features/field/views/fields_views.dart';
import 'package:app/features/calculator/views/widgets/create_button.dart';
import 'package:flutter/material.dart';

class CalculatorFieldsViews extends StatelessWidget {
  const CalculatorFieldsViews({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Поля Калькулятора')),
      body: const SafeArea(child: CalculatorFieldList(calculatorId: '0')),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: CreateButton(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const FieldsViews()),
            );
          },
          title: 'Добавить новое поле',
          isEnabled: true,
        ),
      ),
    );
  }
}
