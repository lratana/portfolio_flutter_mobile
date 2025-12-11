// Education Section
import 'package:flutter/material.dart';

import '../models/portfolio_models.dart';

class EducationSection extends StatelessWidget {
  final Education education;
  final Function(int, EducationItem) onUpdate;
  final Function(int) onDelete;

  const EducationSection({
    super.key,
    required this.education,
    required this.onUpdate,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            education.title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          ...education.timeline.asMap().entries.map((entry) {
            int index = entry.key;
            EducationItem item = entry.value;
            return Card(
              margin: const EdgeInsets.only(bottom: 15),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.year,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.deepPurple,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                item.degree,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                item.institution,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        PopupMenuButton(
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              child: const Text('Edit'),
                              onTap: () {
                                _showEditEducationDialog(context, index, item);
                              },
                            ),
                            PopupMenuItem(
                              child: const Text('Delete'),
                              onTap: () => onDelete(index),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      item.description,
                      style: const TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  void _showEditEducationDialog(
      BuildContext context, int index, EducationItem item) {
    final yearController = TextEditingController(text: item.year);
    final degreeController = TextEditingController(text: item.degree);
    final institutionController = TextEditingController(text: item.institution);
    final descriptionController = TextEditingController(text: item.description);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Education'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: yearController,
                decoration: const InputDecoration(labelText: 'Year'),
              ),
              TextField(
                controller: degreeController,
                decoration: const InputDecoration(labelText: 'Degree'),
              ),
              TextField(
                controller: institutionController,
                decoration: const InputDecoration(labelText: 'Institution'),
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 3,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              onUpdate(
                index,
                EducationItem(
                  year: yearController.text,
                  degree: degreeController.text,
                  institution: institutionController.text,
                  description: descriptionController.text,
                ),
              );
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
