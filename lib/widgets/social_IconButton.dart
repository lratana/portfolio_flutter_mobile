import 'package:flutter/material.dart';

class SocialIconButton extends StatelessWidget {
  final String label;
  final IconData icon;

  const SocialIconButton(this.label, this.icon, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ElevatedButton.icon(
        onPressed: () {},
        icon: Icon(icon),
        label: Text(label),
      ),
    );
  }
}
