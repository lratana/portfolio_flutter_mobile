// Testimonials Section
import 'package:flutter/material.dart';

import '../models/portfolio_models.dart';

class TestimonialsSection extends StatelessWidget {
  final Testimonials testimonials;
  const TestimonialsSection({super.key, required this.testimonials});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            testimonials.title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          ...testimonials.items.map((testimonial) {
            return Card(
              margin: const EdgeInsets.only(bottom: 15),
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Quote
                    Text(
                      testimonial.quote,
                      style: const TextStyle(
                        fontSize: 13,
                        fontStyle: FontStyle.italic,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 15),
                    // Author info with avatar
                    Row(
                      children: [
                        _buildAvatar(testimonial),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              testimonial.name,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              testimonial.role,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                            if (testimonial.company.isNotEmpty)
                              Text(
                                testimonial.company,
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: Colors.deepPurple,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                          ],
                        ),
                      ],
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

  /// Build avatar with image support
  Widget _buildAvatar(Testimonial testimonial) {
    if (testimonial.avatar.isEmpty) {
      // Fallback to initials
      return CircleAvatar(
        radius: 25,
        backgroundColor: Colors.deepPurple,
        child: Text(
          testimonial.name.isNotEmpty ? testimonial.name[0] : '?',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      );
    }

    // Load image from assets
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.deepPurple.withOpacity(0.3), width: 2),
      ),
      child: ClipOval(
        child: _buildImage(testimonial.avatar),
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
          child: Center(
            child: Icon(Icons.person, size: 30, color: Colors.grey[600]),
          ),
        );
      },
    );
  }
}
