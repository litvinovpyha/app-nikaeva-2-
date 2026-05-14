// import 'dart:io';

// import 'package:app/features/clients/models/client.dart';
// import 'package:app/shared/app_color.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:image_picker/image_picker.dart';

// class ProfileHeader extends StatelessWidget {
//   final dynamic client;

//   const ProfileHeader({super.key, required this.client});

//   @override
//   Widget build(BuildContext context) {
//     final photoProvider = _photoProvider(client.photo);

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           children: [
//             GestureDetector(
//               onTap: () => _pickAvatar(context, client),
//               child: Stack(
//                 alignment: AlignmentGeometry.bottomRight,
//                 children: [
//                   CircleAvatar(
//                     radius: 28,
//                     backgroundImage: photoProvider,
//                     child: photoProvider == null
//                         ? const Icon(Icons.person)
//                         : null,
//                   ),
//                   const CircleAvatar(
//                     radius: 10,
//                     backgroundColor: AppColor.primaryColor,
//                     child: Icon(
//                       Icons.edit,
//                       size: 10,
//                       color: AppColor.surfaceColor,
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             const SizedBox(width: 12),
//             Expanded(
//               child: Text(
//                 client.name,
//                 maxLines: 2,
//                 overflow: TextOverflow.ellipsis,
//                 style: Theme.of(context).textTheme.titleLarge,
//               ),
//             ),
//             const SizedBox(width: 8),
//             _QuickAction(icon: Icons.call, onTap: () {}),
//             _QuickAction(
//               icon: Icons.chat,
//               onTap: () {
//                 // TODO: whatsapp (url_launcher)
//               },
//             ),
//           ],
//         ),
//         const SizedBox(height: 10),
//         Wrap(
//           spacing: 8,
//           runSpacing: 8,
//           children: [
//             if ((client.coloringTechnique ?? '').toString().trim().isNotEmpty)
//               Chip(label: Text('Техника: ${client.coloringTechnique}')),
//             if ((client.haircutType ?? '').toString().trim().isNotEmpty)
//               Chip(label: Text('Стрижка: ${client.haircutType}')),
//             if ((client.serviceDuration ?? '').toString().trim().isNotEmpty)
//               Chip(label: Text('Длительность: ${client.serviceDuration}')),
//             if ((client.birthday ?? '').toString().trim().isNotEmpty)
//               Chip(label: Text('ДР: ${client.birthday}')),
//           ],
//         ),
//       ],
//     );
//   }

//   ImageProvider? _photoProvider(String? photo) {
//     if (photo == null || photo.trim().isEmpty) return null;
//     final p = photo.trim();
//     if (p.startsWith('http://') || p.startsWith('https://')) {
//       return NetworkImage(p);
//     }
//     final f = File(p);
//     if (f.existsSync()) return FileImage(f);
//     return null;
//   }
// }

// class _QuickAction extends StatelessWidget {
//   final IconData icon;
//   final VoidCallback onTap;

//   const _QuickAction({required this.icon, required this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     return IconButton(onPressed: onTap, icon: Icon(icon), tooltip: 'Действие');
//   }
// }

// Future<void> _pickAvatar(BuildContext context, Client client) async {
//   final picker = ImagePicker();
//   final xfile = await picker.pickImage(
//     source: ImageSource.gallery,
//     imageQuality: 85,
//   );
//   if (xfile == null) return;

//   if (!context.mounted) return;
//   // context.read<ClientBloc>().add(
//   //   UpdateClient(id: client.id, photo: xfile.path),
//   // );
// }
