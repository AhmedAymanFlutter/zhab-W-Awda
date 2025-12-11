import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../data/models/get_settings_model.dart';
import 'contact_item.dart';

class ContactInfoSection extends StatelessWidget {
  final ContactInfo contactInfo;

  const ContactInfoSection({super.key, required this.contactInfo});

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
                // launchUrl(Uri.parse("tel:${phone.number}"));
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
              onTap: () {},
            ),
          ),
      ],
    );
  }
}
