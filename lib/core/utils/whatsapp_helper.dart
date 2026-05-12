import 'package:url_launcher/url_launcher.dart';

class WhatsAppHelper {
  static Future<void> launchWhatsApp({
    required String phone,
    String message = '',
  }) async {
    final String url = "whatsapp://send?phone=$phone&text=${Uri.encodeComponent(message)}";
    final Uri uri = Uri.parse(url);
    
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      // Fallback to web link
      final String webUrl = "https://wa.me/$phone/?text=${Uri.encodeComponent(message)}";
      final Uri webUri = Uri.parse(webUrl);
      if (await canLaunchUrl(webUri)) {
        await launchUrl(webUri, mode: LaunchMode.externalApplication);
      } else {
        throw 'Could not launch WhatsApp';
      }
    }
  }
}
