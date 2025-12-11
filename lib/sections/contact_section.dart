// Contact Section
import 'package:flutter/material.dart';

import '../models/portfolio_models.dart';
import '../widgets/contract_info.dart';
import '../widgets/social_IconButton.dart';

class ContactSection extends StatelessWidget {
  final Contact contact;
  const ContactSection({super.key, required this.contact});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.deepPurple.withOpacity(0.1),
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      child: Column(
        children: [
          const Text(
            'Get in Touch',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          ContactInfo(
            icon: Icons.email,
            title: 'Email',
            value: contact.email,
          ),
          ContactInfo(
            icon: Icons.phone,
            title: 'Phone',
            value: contact.phone,
          ),
          ContactInfo(
            icon: Icons.location_on,
            title: 'Location',
            value: contact.location,
          ),
          const SizedBox(height: 20),
          const Text(
            'Follow Me',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 50,
            child: ListView(
              padding: EdgeInsets.only(top: 5, bottom: 5),
              shrinkWrap: false,
              scrollDirection: Axis.horizontal,
              children: [
                SocialIconButton('LinkedIn', Icons.link),
                SocialIconButton('GitHub', Icons.code),
                SocialIconButton('Twitter', Icons.share),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
