import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/locale_provider.dart'
    show AppLocalizations, localeProvider;
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
    final locale = ref.watch(localeProvider);

    return Scaffold(
      body: _buildBody(context, ref, portfolioState, locale),
    );
  }

  Widget _buildBody(
      BuildContext context, WidgetRef ref, portfolioState, Locale locale) {
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
              AppLocalizations.t(context, 'common.errorLoading'),
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
              child: Text(AppLocalizations.t(context, 'common.retry')),
            ),
          ],
        ),
      );
    }

    // Empty state
    if (!portfolioState.hasData) {
      return Center(
        child: Text(AppLocalizations.t(context, 'common.noData')),
      );
    }

    // Success - Display portfolio content
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          expandedHeight: 500.0,
          flexibleSpace: FlexibleSpaceBar(
            //  title: Text(portfolioState.hero?.name ?? 'My Portfolio'),
            background: HeroSection(hero: portfolioState.hero!),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  Icon(Icons.language, color: Colors.white),
                  TextButton(
                    onPressed: () {
                      final nextLocale = locale.languageCode == 'en'
                          ? const Locale('km')
                          : const Locale('en');
                      ref.read(localeProvider.notifier).state = nextLocale;
                    },
                    child: Text(
                      locale.languageCode == 'en' ? 'KH' : 'EN',
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              //   HeroSection(hero: portfolioState.hero!),
              ServicesSection(services: portfolioState.services!),
              SkillsSection(skills: portfolioState.skills!),
              EducationSection(education: portfolioState.education!),
              ExperienceSection(experience: portfolioState.experience!),
              WorksSection(works: portfolioState.works!),
              TestimonialsSection(testimonials: portfolioState.testimonials!),
              ContactSection(contact: portfolioState.contact!),
            ],
          ),
        ),
      ],
    );
  }
}
