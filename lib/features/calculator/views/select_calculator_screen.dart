import 'package:app/core/bloc/generic_bloc.dart';
import 'package:app/core/bloc/generic_event.dart';
import 'package:app/core/bloc/generic_state.dart';
import 'package:app/features/calculator/models/calculator.dart';
import 'package:app/features/calculator/views/calculator_create_screen.dart';
import 'package:app/features/calculator/views/widgets/calculator_item.dart';
import 'package:app/features/calculator/views/widgets/create_button.dart';
import 'package:app/features/clients/models/client.dart';
import 'package:app/shared/dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectCalculatorScreen extends StatelessWidget {
  final Client client;
  const SelectCalculatorScreen({super.key, required this.client});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Выбор Калькулятора')),
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: SearchBar(
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(Dimens.radius10),
                        ),
                      ),
                      backgroundColor: WidgetStateProperty.all(
                        const Color(0xFFF8F9FE),
                      ),
                      elevation: WidgetStateProperty.all(0.1),
                      hintText: 'Поиск...',
                      leading: const Padding(
                        padding: EdgeInsets.all(Dimens.padding16),
                        child: Icon(Icons.search),
                      ),
                      onChanged: (query) => context
                          .read<GenericBloc<Calculator>>()
                          .add(SearchItems<Calculator>(query)),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),
              BlocBuilder<GenericBloc<Calculator>, GenericState<Calculator>>(
                builder: (context, state) {
                  if (state is ItemsLoading<Calculator>) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is ItemsLoaded<Calculator>) {
                    final Calculators = state.items;
                    if (Calculators.isEmpty) {
                      return const Center(
                        child: Text('Калькуляторов пока нет'),
                      );
                    }

                    return Expanded(
                      child: ListView.builder(
                        itemCount: Calculators.length,
                        itemBuilder: (context, index) {
                          final c = Calculators[index];

                          return CalculatorItem(title: c.title);
                        },
                      ),
                    );
                  }

                  if (state is ItemsError<Calculator>) {
                    return Center(child: Text(state.message));
                  }

                  return const SizedBox();
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CreateButton(
        isEnabled: true,
        title: 'Создать калькулятор',
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CalculatorCreateScreen(),
            ),
          );
        },
      ),
    );
  }
}
