// Services Section
import 'package:flutter/material.dart';

import '../models/portfolio_models.dart';

class ServicesSection extends StatelessWidget {
  final Services services;
  const ServicesSection({super.key, required this.services});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            services.title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              childAspectRatio: 1.2,
            ),
            itemCount: services.items.length,
            itemBuilder: (context, index) {
              final service = services.items[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 15),
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Icon
                      if (service.icon.isNotEmpty)
                        Container(
                          width: 50,
                          height: 50,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.deepPurple.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: _buildIcon(service.icon),
                        ),
                      const SizedBox(height: 12),
                      // Title
                      Text(
                        service.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Description
                      Text(
                        service.description,
                        style:
                            const TextStyle(fontSize: 13, color: Colors.grey),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 10),
                      // Projects count
                      Text(
                        'Projects: ${service.projects}+',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.deepPurple,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  /// Build icon from asset path
  Widget _buildIcon(String iconPath) {
    // Remove leading slash if present
    String cleanPath = iconPath.startsWith('/') ? iconPath.substring(1) : iconPath;

    // Check if it's an SVG or image
    if (cleanPath.endsWith('.svg')) {
      // For SVG, use a generic icon as fallback
      return Icon(
        Icons.build,
        color: Colors.deepPurple,
        size: 32,
      );
    }

    return Image.asset(
      'assets/$cleanPath',
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) {
        return Icon(
          Icons.build,
          color: Colors.deepPurple,
          size: 32,
        );
      },
    );
  }
}
