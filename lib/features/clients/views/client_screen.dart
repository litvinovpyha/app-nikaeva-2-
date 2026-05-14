import 'package:app/core/auth/presentation/cubits/auth_cubits.dart';
import 'package:app/core/auth/presentation/cubits/auth_states.dart';
import 'package:app/core/bloc/generic_bloc.dart';
import 'package:app/core/bloc/generic_event.dart';
import 'package:app/core/bloc/generic_state.dart';
import 'package:app/features/clients/models/client.dart';
import 'package:app/features/clients/views/client_profile_screen.dart';
import 'package:app/features/clients/views/create_client_screen.dart';
import 'package:app/features/clients/views/widgets/client_item.dart';
import 'package:flutter/material.dart';
import 'package:app/shared/dimens.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClientScreen extends StatelessWidget {
  final void Function(Client client)? onClientTap;

  const ClientScreen({super.key, this.onClientTap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 8,
                bottom: 16,
                right: 16,
                left: 64,
              ),
              child: Row(
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
                          .read<GenericBloc<Client>>()
                          .add(SearchItems<Client>(query)),
                    ),
                  ),
                  const SizedBox(width: Dimens.width16),
                  FloatingActionButton(
                    heroTag: 'create-client-btn',
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(Dimens.radius10),
                    ),
                    backgroundColor: const Color(0xFFF8F9FE),
                    elevation: Dimens.elevation006,
                    child: const Icon(Icons.add, color: Color(0xFF2F3036)),
                    onPressed: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const CreateClientScreen(),
                        ),
                      );
                      final authState = context.read<AuthCubits>().state;

                      if (authState is Authenticated) {
                        if (result != null) {
                          context.read<GenericBloc<Client>>().add(
                            CreateItem<Client>(
                              Client(
                                id: '',
                                name: result['name'],
                                phone: result['phone'],
                              ),
                            ),
                          );
                        }
                      }
                    },
                  ),
                ],
              ),
            ),

            BlocBuilder<GenericBloc<Client>, GenericState<Client>>(
              builder: (context, state) {
                if (state is ItemsLoading<Client>) {
                  return const Expanded(
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                if (state is ItemsLoaded<Client>) {
                  final clients = state.items;
                  if (clients.isEmpty) {
                    return const Expanded(
                      child: Center(child: Text('Список клиентов пуст!')),
                    );
                  }

                  return Expanded(
                    child: ListView.builder(
                      itemCount: clients.length,
                      itemBuilder: (context, index) {
                        final client = clients[index];

                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: ClientItem(
                            onTap: () {
                              if (onClientTap != null) {
                                onClientTap!(client);
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ClientProfileScreen(
                                      clientId: client.id,
                                    ),
                                  ),
                                );
                              }
                            },
                            phone: client.phone ?? 'Не указан',
                            photo: client.photo ?? 'assets/avatars/avatar.png',
                            name: client.name,
                          ),
                        );
                      },
                    ),
                  );
                }

                if (state is ItemsError<Client>) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(child: Text(state.message)),
                  );
                }

                return const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}
