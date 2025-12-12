// Works Section
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/portfolio_provider.dart';
import '../models/portfolio_models.dart';

class WorksSection extends StatelessWidget {
  final Works works;

  const WorksSection({
    super.key,
    required this.works,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            works.title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            works.note,
            style: const TextStyle(fontSize: 13, color: Colors.grey),
          ),
          const SizedBox(height: 20),
          ...works.items.map((work) {
            return Card(
              margin: const EdgeInsets.only(bottom: 15),
              elevation: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Cover Image
                  if (work.cover.isNotEmpty)
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(4),
                        topRight: Radius.circular(4),
                      ),
                      child: Container(
                        width: double.infinity,
                        height: 200,
                        color: Colors.grey[300],
                        child: _buildImage(work.cover),
                      ),
                    ),
                  // Content
                  Padding(
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
                                    work.title,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    work.subtitle,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                final container =
                                    ProviderScope.containerOf(context);
                                container
                                    .read(portfolioProvider.notifier)
                                    .deleteWorkItem(work.id);
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        // Tags
                        Wrap(
                          spacing: 8,
                          children: work.tags.map((tag) {
                            return Chip(
                              label: Text(tag),
                              backgroundColor:
                                  Colors.deepPurple.withOpacity(0.1),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  /// Build image widget - handles asset paths
  Widget _buildImage(String imagePath) {
    // Remove leading slash if present
    String cleanPath =
        imagePath.startsWith('/') ? imagePath.substring(1) : imagePath;

    return Image.asset(
      'assets/$cleanPath',
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          color: Colors.grey[300],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.image_not_supported,
                  color: Colors.grey[600], size: 48),
              const SizedBox(height: 8),
              Text(
                'Image not found',
                style: TextStyle(color: Colors.grey[600]),
              ),
            ],
          ),
        );
      },
    );
  }
}
