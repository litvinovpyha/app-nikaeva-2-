import 'package:app/constants.dart';
import 'package:app/core/bloc/generic_bloc.dart';
import 'package:app/core/bloc/generic_event.dart';
import 'package:app/core/bloc/generic_state.dart';
import 'package:app/features/booking/model/booking.dart';
import 'package:app/features/booking/views/booking_screen.dart';
import 'package:app/features/clients/models/client.dart';
import 'package:app/features/clients/views/edit/edit_birthday_screen.dart';
import 'package:app/features/clients/views/edit/edit_comment_screen.dart';
import 'package:app/features/clients/views/edit/edit_contacts_info_screen.dart';
import 'package:app/features/clients/views/edit/edit_name_screen.dart';
import 'package:app/features/clients/views/edit/edit_phone_screen.dart';
import 'package:app/features/clients/views/widgets/client_action_button.dart';
import 'package:app/features/userservice/views/select_service_screen.dart';
import 'package:app/features/booking/views/booking_by_client_screen.dart';
import 'package:app/shared/formatters/date_formatter.dart';
import 'package:app/shared/links/open_dialer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

class ClientProfileScreen extends StatelessWidget {
  final String clientId;
  const ClientProfileScreen({super.key, required this.clientId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F3F5),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
      ),
      body: BlocBuilder<GenericBloc<Client>, GenericState<Client>>(
        builder: (context, state) {
          if (state is ItemsLoaded<Client>) {
            final client = state.items.firstWhere((e) => e.id == clientId);

            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),

                        Center(
                          child: Stack(
                            children: [
                              CircleAvatar(
                                radius: 40,
                                backgroundColor: backgroundColor2.withValues(
                                  alpha: 0.3,
                                ),
                                child: Icon(
                                  Icons.person,
                                  size: 40,
                                  color: backgroundColor2.withValues(
                                    alpha: 0.7,
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 0,
                                right: 0,
                                child: GestureDetector(
                                  onTap: () {},
                                  child: const CircleAvatar(
                                    radius: 13,
                                    child: Icon(Icons.edit, size: 15),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 12),

                        Center(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                client.name,
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),

                              const SizedBox(width: 6),

                              GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () async {
                                  final result = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => EditNameScreen(
                                        initialValue: client.name,
                                      ),
                                    ),
                                  );

                                  if (result != null) {
                                    context.read<GenericBloc<Client>>().add(
                                      UpdateItem(
                                        client.copyWith(name: result),
                                        client.id,
                                      ),
                                    );
                                  }
                                },
                                child: const Padding(
                                  padding: EdgeInsets.all(6),
                                  child: Icon(Icons.edit, size: 18),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 16),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ClientActionButton(
                              FontAwesomeIcons.phone,
                              onTap: () => openDialer(client.phone!),
                            ),

                            ClientActionButton(
                              FontAwesomeIcons.whatsapp,
                              onTap: () => openWhatsApp(client.phone!),
                            ),

                            ClientActionButton(
                              FontAwesomeIcons.instagram,
                              onTap: () => openInstagram(client.inst ?? ''),
                            ),

                            ClientActionButton(
                              FontAwesomeIcons.telegram,
                              onTap: () => openTelegram(client.telegram ?? ''),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              backgroundColor: backgroundColor2.withValues(
                                alpha: 0.7,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      SelectServiceScreen(client: client),
                                ),
                              );
                            },
                            child: Text(
                              "Запланировать посещение",
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.tertiary,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        const Text(
                          "Комментарий о клиенте:",
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 8),
                        _emptyCard(
                          client.comment ?? "Нет данных.",
                          true,
                          () async {
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => EditCommentScreen(
                                  initialValue: client.comment,
                                ),
                              ),
                            );

                            if (result != null) {
                              context.read<GenericBloc<Client>>().add(
                                UpdateItem(
                                  client.copyWith(comment: result),
                                  client.id,
                                ),
                              );
                            }
                          },
                        ),

                        const SizedBox(height: 20),

                        BlocBuilder<
                          GenericBloc<Booking>,
                          GenericState<Booking>
                        >(
                          builder: (context, state) {
                            if (state is ItemsLoading<Booking>) {
                              return const CircularProgressIndicator();
                            }

                            if (state is ItemsLoaded<Booking>) {
                              final bookings = state.items;

                              final clientBookings = bookings
                                  .where((b) => b.clientId == clientId)
                                  .toList();

                              if (clientBookings.isEmpty) {
                                return Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text("Ближайшая запись:"),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    BookingByClientScreen(
                                                      clientId: clientId,
                                                    ),
                                              ),
                                            );
                                          },
                                          child: Text(
                                            "Все записи",
                                            style: TextStyle(
                                              color: backgroundColor2
                                                  .withValues(alpha: 0.7),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 16),
                                    const Row(children: [Text("Нет записей")]),
                                  ],
                                );
                              }

                              final sorted = [...clientBookings]
                                ..sort((a, b) => a.date.compareTo(b.date));

                              final lastBooking = sorted.last;

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text("Ближайшая запись:"),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  BookingByClientScreen(
                                                    clientId: clientId,
                                                  ),
                                            ),
                                          );
                                        },
                                        child: Text(
                                          "Все записи",
                                          style: TextStyle(
                                            color: backgroundColor2.withValues(
                                              alpha: 0.7,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 10),

                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => BookingScreen(
                                            bookingId: lastBooking.id,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            DateFormat(
                                              'dd.MM.yyyy в HH:mm',
                                            ).format(
                                              lastBooking.date.toLocal(),
                                            ),
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                lastBooking
                                                    .servicesNames!
                                                    .first,
                                              ),
                                              Text(
                                                lastBooking.clientName ?? '',
                                                style: const TextStyle(
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }

                            return const SizedBox();
                          },
                        ),
                        const SizedBox(height: 8),
                        const SizedBox(height: 20),

                        const Text("Контакты", style: TextStyle(fontSize: 16)),
                        const SizedBox(height: 10),

                        _contactTile(
                          FontAwesomeIcons.whatsapp,
                          'Мобильный',
                          client.phone ?? 'Нет данных.',
                          () async {
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    EditPhoneScreen(initialValue: client.phone),
                              ),
                            );
                            if (result != null) {
                              context.read<GenericBloc<Client>>().add(
                                UpdateItem(
                                  client.copyWith(phone: result),
                                  client.id,
                                ),
                              );
                            }
                            return;
                          },
                          () => openWhatsApp(client.phone!),
                        ),
                        _contactTile(
                          FontAwesomeIcons.instagram,
                          "Инстаграм",
                          client.inst ?? "Нет данных.",
                          () async {
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => EditContactsInfoScreen(
                                  title: "Инстаграм",
                                  initialValue: client.inst ?? null,
                                ),
                              ),
                            );
                            if (result != null) {
                              context.read<GenericBloc<Client>>().add(
                                UpdateItem(
                                  client.copyWith(inst: result),
                                  client.id,
                                ),
                              );
                            }
                            return;
                          },
                          () => openInstagram(client.inst ?? ''),
                        ),
                        _contactTile(
                          FontAwesomeIcons.telegram,
                          "Телеграм",
                          client.telegram ?? "Нет данных.",
                          () async {
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => EditContactsInfoScreen(
                                  title: "Телеграм",
                                  initialValue: client.telegram ?? null,
                                ),
                              ),
                            );
                            if (result != null) {
                              context.read<GenericBloc<Client>>().add(
                                UpdateItem(
                                  client.copyWith(telegram: result),
                                  client.id,
                                ),
                              );
                            }
                            return;
                          },
                          () => openTelegram(client.telegram ?? ''),
                        ),
                        _contactTile(
                          FontAwesomeIcons.cakeCandles,
                          "День рождения",
                          client.birthDay != null
                              ? dateFormatter(client.birthDay!)
                              : "Нет данных",
                          () async {
                            final result = await Navigator.push<DateTime>(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const EditBirthdayScreen(),
                              ),
                            );

                            if (result != null) {
                              context.read<GenericBloc<Client>>().add(
                                UpdateItem(
                                  client.copyWith(birthDay: result),
                                  client.id,
                                ),
                              );
                            }
                            return;
                          },
                          () {},
                        ),
                        const SizedBox(height: 24),
                        InkWell(
                          onTap: () {
                            context.read<GenericBloc<Client>>().add(
                              DeleteItem(client.id),
                            );
                            Navigator.pop(context);
                          },
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const ListTile(
                              title: Center(
                                child: Text(
                                  'Удалить клиента',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _emptyCard(String text, bool edit, VoidCallback onTap) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Text(text),
        ),
        if (edit == true)
          Positioned(
            top: 0,
            right: 0,
            child: GestureDetector(
              onTap: onTap,
              child: const CircleAvatar(
                radius: 13,
                child: Icon(Icons.edit, size: 15),
              ),
            ),
          ),
      ],
    );
  }

  Widget _contactTile(
    FaIconData icon,
    String title,
    String value,
    VoidCallback onEdit,
    VoidCallback onTap,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        children: [
          GestureDetector(
            onTap: onTap,
            child: ListTile(
              leading: FaIcon(
                icon,
                color: backgroundColor2.withValues(alpha: 0.7),
              ),
              title: Text(title),
              trailing: Text(value),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: GestureDetector(
              onTap: onEdit,
              child: const CircleAvatar(
                radius: 13,
                child: Icon(Icons.edit, size: 15),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

String normalizeNick(String nick) {
  return nick.startsWith('@') ? nick.substring(1) : nick;
}

void openInstagram(String nick) {
  final username = normalizeNick(nick);
  final url = Uri.parse('https://instagram.com/$username');

  launchUrl(url, mode: LaunchMode.externalApplication);
}

void openTelegram(String nick) {
  final username = normalizeNick(nick);
  final url = Uri.parse('https://t.me/$username');

  launchUrl(url, mode: LaunchMode.externalApplication);
}

void openWhatsApp(String phone) {
  final number = normalizePhone(phone);
  final url = Uri.parse('https://wa.me/$number');

  launchUrl(url, mode: LaunchMode.externalApplication);
}

String normalizePhone(String phone) {
  return phone.replaceAll(RegExp(r'\D'), '');
}
