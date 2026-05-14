import 'package:app/core/bloc/generic_bloc.dart';
import 'package:app/core/bloc/generic_event.dart';
import 'package:app/features/field/models/field.dart';
import 'package:app/features/calculator/views/widgets/fixed_price_switch.dart';
import 'package:app/features/calculator/views/widgets/create_button.dart';
import 'package:app/features/calculator/views/widgets/my_text_field.dart';
import 'package:app/features/field/views/fields_views.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FieldCreateScreen extends StatefulWidget {
  const FieldCreateScreen({super.key});

  @override
  State<FieldCreateScreen> createState() => _FieldCreateScreenState();
}

class _FieldCreateScreenState extends State<FieldCreateScreen> {
  final TextEditingController _labelController = TextEditingController();
  final TextEditingController _hintTextcontroller = TextEditingController();
  bool isFixedPrice = false;

  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _labelController.addListener(() {
      setState(() {
        _isButtonEnabled = _labelController.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _labelController.dispose();
    _hintTextcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Создать поле')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
          child: Column(
            children: [
              MyTextField(
                controller: _labelController,
                title: 'Введите название (Например: Краситель)',
              ),
              const SizedBox(height: 16),
              MyTextField(
                controller: _hintTextcontroller,
                title: 'Введите единицу (по умолчанию: Грамм)',
              ),

              FixedPriceSwitch(
                value: isFixedPrice,
                onChanged: (val) {
                  setState(() {
                    isFixedPrice = val;
                  });
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: CreateButton(
          onTap: _isButtonEnabled
              ? () {
                  context.read<GenericBloc<Field>>().add(
                    CreateItem<Field>(
                      Field(
                        id: '',
                        title: _labelController.text,
                        hint: _hintTextcontroller.text,
                        isChecked: isFixedPrice,
                      ),
                    ),
                  );

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FieldsViews(),
                    ),
                  );
                }
              : null,
          title: 'Добавить название и продолжить',
          isEnabled: _isButtonEnabled,
        ),
      ),
    );
  }
}
