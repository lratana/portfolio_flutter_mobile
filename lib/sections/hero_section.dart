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
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.deepPurple,
            child: Text(
              hero.name[0],
              style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
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
}
