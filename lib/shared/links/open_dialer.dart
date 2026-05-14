import 'package:url_launcher/url_launcher.dart';

Future<void> openDialer(String? phoneNumber) async {
  if (phoneNumber == null) return;
  String cleaned = phoneNumber.replaceAll(RegExp(r'[^0-9+]'), '');
  if (cleaned.startsWith('8') && cleaned.length == 11) {
    cleaned = '+7${cleaned.substring(1)}';
  }
  if (cleaned.startsWith('7') && !cleaned.startsWith('+7')) {
    cleaned = '+$cleaned';
  }
  if (cleaned.isEmpty) return;

  final Uri uri = Uri(scheme: 'tel', path: cleaned);

  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}
