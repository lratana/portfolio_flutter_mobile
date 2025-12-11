// Hero Section
import 'package:flutter/material.dart';
import 'package:sample_project/models/portfolio_models.dart';

class HeroSection extends StatelessWidget {
  final PersonalProfile hero;
  const HeroSection({super.key, required this.hero});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.deepPurple.withOpacity(0.1),
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      child: Column(
        children: [
          // Avatar with Image
          _buildAvatar(),
          const SizedBox(height: 20),
          Text(
            hero.greeting,
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
          Text(
            hero.name,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            hero.tagline,
            style: const TextStyle(fontSize: 14, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: hero.stats.map((stat) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Text(
                      '${stat.value}${stat.suffix}',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      stat.label,
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Get in Touch'),
          ),
        ],
      ),
    );
  }

  /// Build avatar with image support
  Widget _buildAvatar() {
    if (hero.avatar.isEmpty) {
      // Fallback to initials
      return CircleAvatar(
        radius: 50,
        backgroundColor: Colors.deepPurple,
        child: Text(
          hero.name.isNotEmpty ? hero.name[0] : '?',
          style: const TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      );
    }

    // Load image from assets
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.deepPurple, width: 3),
        boxShadow: [
          BoxShadow(
            color: Colors.deepPurple.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ClipOval(
        child: _buildImage(hero.avatar),
      ),
    );
  }

  /// Build image widget - handles asset paths
  Widget _buildImage(String imagePath) {
    // Remove leading slash if present
    String cleanPath = imagePath.startsWith('/') ? imagePath.substring(1) : imagePath;

    return Image.asset(
      'assets/$cleanPath',
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          color: Colors.grey[300],
          child: Center(
            child: Icon(Icons.person, size: 60, color: Colors.grey[600]),
          ),
        );
      },
    );
  }
}
