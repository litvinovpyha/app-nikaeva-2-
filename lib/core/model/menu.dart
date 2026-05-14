import 'package:app/core/model/rive_model.dart';
import 'package:app/features/notification/views/notification_page.dart';
import 'package:app/features/clients/views/client_screen.dart';
import 'package:app/features/history/views/history_page.dart';
import 'package:app/features/home/views/home_screen.dart';
import 'package:flutter/cupertino.dart';

class Menu {
  final String title;
  final RiveModel rive;
  final Widget page; // 👈 добавили

  Menu({required this.title, required this.rive, required this.page});
}

List<Menu> sidebarMenus = [
  Menu(
    title: "Главная",
    rive: RiveModel(
      src: "assets/RiveAssets/icons.riv",
      artboard: "HOME",
      stateMachineName: "HOME_interactivity",
    ),
    page: HomePage(),
  ),

  Menu(
    title: "Поиск",
    rive: RiveModel(
      src: "assets/RiveAssets/icons.riv",
      artboard: "SEARCH",
      stateMachineName: "SEARCH_Interactivity",
    ),
    page: HomePage(),
  ),
  Menu(
    title: "Избранное",
    rive: RiveModel(
      src: "assets/RiveAssets/icons.riv",
      artboard: "LIKE/STAR",
      stateMachineName: "STAR_Interactivity",
    ),
    page: HomePage(),
  ),
  Menu(
    title: "Помощь",
    rive: RiveModel(
      src: "assets/RiveAssets/icons.riv",
      artboard: "CHAT",
      stateMachineName: "CHAT_Interactivity",
    ),
    page: HomePage(),
  ),
];
List<Menu> sidebarMenus2 = [
  Menu(
    title: "История",
    rive: RiveModel(
      src: "assets/RiveAssets/icons.riv",
      artboard: "TIMER",
      stateMachineName: "TIMER_Interactivity",
    ),
    page: const HistoryPage(),
  ),
  Menu(
    title: "Уведомления",
    rive: RiveModel(
      src: "assets/RiveAssets/icons.riv",
      artboard: "BELL",
      stateMachineName: "BELL_Interactivity",
    ),
    page: HomePage(),
  ),
  Menu(
    title: "Выйти",
    rive: RiveModel(
      src: "assets/RiveAssets/icons.riv",
      artboard: "BELL",
      stateMachineName: "BELL_Interactivity",
    ),
    page: HomePage(),
  ),
];

List<Menu> bottomNavItems = [
  // Menu(
  //   title: "Chat",
  //   rive: RiveModel(
  //       src: "assets/RiveAssets/icons.riv",
  //       artboard: "CHAT",
  //       stateMachineName: "CHAT_Interactivity"),
  // ),
  Menu(
    title: "Главная",
    rive: RiveModel(
      src: "assets/RiveAssets/icons.riv",
      artboard: "HOME",
      stateMachineName: "HOME_interactivity",
    ),
    page: HomePage(),
  ),
  Menu(
    title: "Клиенты",
    rive: RiveModel(
      src: "assets/RiveAssets/icons.riv",
      artboard: "USER",
      stateMachineName: "USER_Interactivity",
    ),
    page: const ClientScreen(),
  ),
  // Menu(
  //   title: "Search",
  //   rive: RiveModel(
  //     src: "assets/RiveAssets/icons.riv",
  //     artboard: "SEARCH",
  //     stateMachineName: "SEARCH_Interactivity",
  //   ),
  // ),
  Menu(
    title: "История",
    rive: RiveModel(
      src: "assets/RiveAssets/icons.riv",
      artboard: "TIMER",
      stateMachineName: "TIMER_Interactivity",
    ),
    page: const HistoryPage(),
  ),
  // Menu(
  //   title: "Help",
  //   rive: RiveModel(
  //     src: "assets/RiveAssets/icons.riv",
  //     artboard: "CHAT",
  //     stateMachineName: "CHAT_Interactivity",
  //   ),
  // ),
  Menu(
    title: "Уведомления",
    rive: RiveModel(
      src: "assets/RiveAssets/icons.riv",
      artboard: "BELL",
      stateMachineName: "BELL_Interactivity",
    ),
    page: const NotificationPage(),
  ),
];
