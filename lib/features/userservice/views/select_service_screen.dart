import 'package:app/core/auth/presentation/cubits/auth_cubits.dart';
import 'package:app/core/auth/presentation/cubits/auth_states.dart';
import 'package:app/core/bloc/generic_bloc.dart';
import 'package:app/core/bloc/generic_event.dart';
import 'package:app/core/bloc/generic_state.dart';
import 'package:app/features/clients/models/client.dart';
import 'package:app/features/booking/views/create/select_date_screen.dart';
import 'package:app/features/userservice/model/user_service.dart';
import 'package:app/features/userservice/views/create_user_service_screen.dart';
import 'package:app/features/userservice/views/widgets/user_service_item.dart';
import 'package:app/shared/dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectServiceScreen extends StatefulWidget {
  final Client client;
  const SelectServiceScreen({super.key, required this.client});

  @override
  State<SelectServiceScreen> createState() => _SelectServiceScreenState();
}

class _SelectServiceScreenState extends State<SelectServiceScreen> {
  final Set<UserService> selectedServices = {};
  void toggleService(UserService id) {
    setState(() {
      if (selectedServices.contains(id)) {
        selectedServices.remove(id);
      } else {
        selectedServices.add(id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Выбор Услуги")),
      body: SafeArea(
        child: Column(
          children: [
            BlocBuilder<GenericBloc<UserService>, GenericState<UserService>>(
              builder: (context, state) {
                if (state is ItemsLoading<UserService>) {
                  return const Expanded(
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                if (state is ItemsLoaded<UserService>) {
                  final userServices = state.items;

                  if (userServices.isEmpty) {
                    return const Expanded(
                      child: Center(child: Text('Список сервисов пуст!')),
                    );
                  }

                  return Expanded(
                    child: ListView.builder(
                      itemCount: userServices.length,
                      itemBuilder: (context, index) {
                        final userService = userServices[index];
                        final isSelected = selectedServices.contains(userService);

                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: UserServiceItem(
                            title: userService.name,
                            isSelected: isSelected,
                            onTap: () => toggleService(userService),
                          ),
                        );
                      },
                    ),
                  );
                }

                if (state is ItemsError<UserService>) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(child: Text(state.message)),
                  );
                }

                return const SizedBox();
              },
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  
                  Expanded(
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              Dimens.radius10,
                            ),
                          ),
                        ),
                        backgroundColor: WidgetStateProperty.all(
                          const Color(0xFFF8F9FE),
                        ),
                        elevation: WidgetStateProperty.all(0.1),
                        padding: WidgetStateProperty.all(
                          const EdgeInsets.symmetric(vertical: 16),
                        ),
                      ),

                      onPressed: selectedServices.isEmpty
                          ? null
                          : () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => SelectDateScreen(
                                    client: widget.client,
                                    services: selectedServices,
                                  ),
                                ),
                              );
                            },
                      child: Text("Продолжить (${selectedServices.length})"),
                    ),
                  ),
                  const SizedBox(width: Dimens.width16),
                  FloatingActionButton(
                    heroTag: 'create-user-service-btn',
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(Dimens.radius10),
                    ),
                    backgroundColor: const Color(0xFFF8F9FE),
                    elevation: Dimens.elevation006,
                    child: const Icon(Icons.add, color: Color(0xFF2F3036)),
                    onPressed: () async {
                      final String result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const CreateUserServiceScreen(),
                        ),
                      );
                      final authState = context.read<AuthCubits>().state;

                      if (authState is Authenticated) {
                        context.read<GenericBloc<UserService>>().add(
                          CreateItem<UserService>(
                            UserService(id: '',  name: result),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
