import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/portfolio_provider.dart';
import '../sections/contact_section.dart';
import '../sections/education_section.dart';
import '../sections/experience_section.dart';
import '../sections/hero_section.dart';
import '../sections/service_section.dart';
import '../sections/skills_section.dart';
import '../sections/testimonials_section.dart';
import '../sections/works_section.dart';

class PortfolioHomePage extends StatelessWidget {
  const PortfolioHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('My Portfolio'),
        elevation: 0,
      ),
      body: Consumer<PortfolioProvider>(
        builder: (context, provider, child) {
          // Loading state
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          // Error state
          if (provider.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 48, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    'Error loading portfolio',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    provider.errorMessage ?? 'Unknown error',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => provider.loadPortfolioData(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          // Empty state
          if (!provider.hasData) {
            return const Center(
              child: Text('No portfolio data available'),
            );
          }

          // Success - Display portfolio content
          return SingleChildScrollView(
            child: Column(
              children: [
                HeroSection(hero: provider.hero!),
                ServicesSection(services: provider.services!),
                SkillsSection(skills: provider.skills!),
                EducationSection(education: provider.education!),
                ExperienceSection(experience: provider.experience!),
                WorksSection(works: provider.works!),
                TestimonialsSection(testimonials: provider.testimonials!),
                ContactSection(contact: provider.contact!),
              ],
            ),
          );
        },
      ),
    );
  }
}
