import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart'; // Import this
import '../../data/models/get_settings_model.dart';
import 'contact_item.dart';

class ContactInfoSection extends StatelessWidget {
  final ContactInfo contactInfo;

  const ContactInfoSection({super.key, required this.contactInfo});

  // --- Helper for Phone Calls ---
  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
    await launchUrl(launchUri);
  }

  // --- Helper for Emails ---
  Future<void> _sendEmail(String emailAddress) async {
    final Uri launchUri = Uri(scheme: 'mailto', path: emailAddress);
    await launchUrl(launchUri);
  }

  // --- Helper for Maps (Optional) ---
  Future<void> _openMap(String address) async {
    // Opens Google Maps search with the address
    final Uri launchUri = Uri.parse(
      "https://www.google.com/maps/search/?api=1&query=$address",
    );
    await launchUrl(launchUri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "طرق التواصل",
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 16.h),

        // Addresses
        if (contactInfo.addresses != null)
          ...contactInfo.addresses!.map(
            (address) => ContactItem(
              icon: Icons.location_on_outlined,
              title: address,
              subtitle: "العنوان",
              onTap: () => _openMap(address), // Opens Maps
            ),
          ),

        // Phones
        if (contactInfo.phones != null)
          ...contactInfo.phones!.map(
            (phone) => ContactItem(
              icon: Icons.phone_outlined,
              title: "${phone.countryCode ?? ''} ${phone.number ?? ''}",
              subtitle: phone.label ?? "رقم الهاتف",
              onTap: () {
                if (phone.number != null) {
                  _makePhoneCall(phone.number!); // Triggers Call
                }
              },
            ),
          ),

        // Emails
        if (contactInfo.emails != null)
          ...contactInfo.emails!.map(
            (email) => ContactItem(
              icon: Icons.email_outlined,
              title: email.email ?? "",
              subtitle: email.label ?? "البريد الإلكتروني",
              onTap: () {
                if (email.email != null) {
                  _sendEmail(email.email!); // Opens Email App
                }
              },
            ),
          ),
      ],
    );
  }
}
