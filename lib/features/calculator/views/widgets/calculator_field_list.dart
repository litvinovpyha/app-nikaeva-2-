import 'package:app/core/bloc/generic_bloc.dart';
import 'package:app/core/bloc/generic_event.dart';
import 'package:app/core/bloc/generic_state.dart';
import 'package:app/features/calculator/models/calculator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalculatorFieldList extends StatefulWidget {
  final String calculatorId;
  const CalculatorFieldList({super.key, required this.calculatorId});

  @override
  State<CalculatorFieldList> createState() => _CalculatorFieldListState();
}

class _CalculatorFieldListState extends State<CalculatorFieldList> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<GenericBloc<Calculator>>().add(
        LoadItemById<Calculator>(widget.calculatorId),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GenericBloc<Calculator>, GenericState<Calculator>>(
      builder: (context, state) {
        if (state is ItemsLoading<Calculator>) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is ItemsLoaded<Calculator>) {
          final calculator = state.items.first;

          if (calculator.calculatorFields!.isEmpty) {
            return const Center(child: Text('Поля пока не добавлены/созданы'));
          }

          return Expanded(
            child: ListView.builder(
              itemCount: calculator.calculatorFields!.length,
              itemBuilder: (context, index) {
                final field = calculator.calculatorFields![index];

                return ListTile(
                  // переход на создание бренда это все поле кроме удаления
                  leading: const SizedBox(width: 60, height: 60),
                  title: Text(field.title),
                  // удалить из списка полей калькулятора а не поле.
                );
              },
            ),
          );
        }

        if (state is ItemsError<Calculator>) {
          return Center(child: Text(state.message));
        }

        return const SizedBox();
      },
    );
  }
}
