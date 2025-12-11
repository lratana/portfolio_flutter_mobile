import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/portfolio_provider.dart';
import '../sections/contact_section.dart';
import '../sections/education_section.dart';
import '../sections/experience_section.dart';
import '../sections/hero_section.dart';
import '../sections/service_section.dart';
import '../sections/skills_section.dart';
import '../sections/testimonials_section.dart';
import '../sections/works_section.dart';

class PortfolioHomePage extends ConsumerWidget {
  const PortfolioHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final portfolioState = ref.watch(portfolioProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('My Portfolio'),
        elevation: 0,
      ),
      body: _buildBody(context, ref, portfolioState),
    );
  }

  Widget _buildBody(BuildContext context, WidgetRef ref, portfolioState) {
    // Loading state
    if (portfolioState.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    // Error state
    if (portfolioState.hasError) {
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
              portfolioState.errorMessage ?? 'Unknown error',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                ref.read(portfolioProvider.notifier).loadPortfolioData();
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    // Empty state
    if (!portfolioState.hasData) {
      return const Center(
        child: Text('No portfolio data available'),
      );
    }

    // Success - Display portfolio content
    return SingleChildScrollView(
      child: Column(
        children: [
          HeroSection(hero: portfolioState.hero!),
          ServicesSection(services: portfolioState.services!),
          SkillsSection(skills: portfolioState.skills!),
          EducationSection(education: portfolioState.education!),
          ExperienceSection(experience: portfolioState.experience!),
          WorksSection(works: portfolioState.works!),
          TestimonialsSection(testimonials: portfolioState.testimonials!),
          ContactSection(contact: portfolioState.contact!),
        ],
      ),
    );
  }
}
