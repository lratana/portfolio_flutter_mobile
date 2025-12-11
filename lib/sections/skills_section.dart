// Skills Section
import 'package:flutter/material.dart';

import '../models/portfolio_models.dart';

class SkillsSection extends StatelessWidget {
  final Skills skills;
  const SkillsSection({super.key, required this.skills});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            skills.title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          ...skills.categories.map((category) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    category.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: category.skills.map((skill) {
                      return Chip(
                        label: Text(skill),
                        backgroundColor: Colors.deepPurple.withOpacity(0.1),
                      );
                    }).toList(),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
