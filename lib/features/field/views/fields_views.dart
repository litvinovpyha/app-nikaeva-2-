import 'package:app/core/bloc/generic_bloc.dart';
import 'package:app/core/bloc/generic_event.dart';
import 'package:app/core/bloc/generic_state.dart';
import 'package:app/features/field/models/field.dart';
import 'package:app/features/field/views/field_create_screen.dart';
import 'package:app/features/calculator/views/widgets/create_button.dart';
import 'package:app/features/field/views/widgets/field_item.dart';
import 'package:app/shared/dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FieldsViews extends StatelessWidget {
  const FieldsViews({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Список доступных полей')),
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
                          .read<GenericBloc<Field>>()
                          .add(SearchItems<Field>(query)),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),
              BlocBuilder<GenericBloc<Field>, GenericState<Field>>(
                builder: (context, state) {
                  if (state is ItemsLoading<Field>) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is ItemsLoaded<Field>) {
                    final Calculators = state.items;
                    if (Calculators.isEmpty) {
                      return const Center(child: Text('полей пока нет'));
                    }

                    return Expanded(
                      child: ListView.builder(
                        itemCount: Calculators.length,
                        itemBuilder: (context, index) {
                          final c = Calculators[index];

                          return FieldItem(title: c.title);
                        },
                      ),
                    );
                  }

                  if (state is ItemsError<Field>) {
                    return Center(child: Text(state.message));
                  }

                  return const SizedBox();
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: CreateButton(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const FieldCreateScreen(),
              ),
            );
          },
          title: 'Создать новое поле',
          isEnabled: true,
        ),
      ),
    );
  }
}
