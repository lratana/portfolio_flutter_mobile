import 'package:flutter/material.dart';
import 'package:sample_project/services/portfolio_service.dart';
import '../models/portfolio_models.dart';
import '../sections/contact_section.dart';
import '../sections/education_section.dart';
import '../sections/experience_section.dart';
import '../sections/hero_section.dart';
import '../sections/service_section.dart';
import '../sections/skills_section.dart';
import '../sections/testimonials_section.dart';
import '../sections/works_section.dart';

class PortfolioHomePage extends StatefulWidget {
  const PortfolioHomePage({super.key});

  @override
  State<PortfolioHomePage> createState() => _PortfolioHomePageState();
}

class _PortfolioHomePageState extends State<PortfolioHomePage> {
  final PortfolioService _portfolioService = PortfolioService();
  late Future<PortfolioData> _dataFuture;

  @override
  void initState() {
    super.initState();
    _dataFuture = _portfolioService.loadJsonData();
  }

  @override
  void dispose() {
    _portfolioService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('My Portfolio'),
        elevation: 0,
      ),
      body: FutureBuilder<PortfolioData>(
        future: _dataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          if (!snapshot.hasData) {
            return const Center(child: Text('No data available'));
          }

          final data = snapshot.data!;
          return StreamBuilder<PortfolioData>(
            stream: _portfolioService.dataStream,
            initialData: data,
            builder: (context, streamSnapshot) {
              if (!streamSnapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              final currentData = streamSnapshot.data!;
              return SingleChildScrollView(
                child: Column(
                  children: [
                    HeroSection(hero: currentData.hero),
                    ServicesSection(services: currentData.services),
                    SkillsSection(skills: currentData.skills),
                    EducationSection(
                      education: currentData.education,
                      onUpdate: (index, item) {
                        _portfolioService.updateEducationItem(index, item);
                      },
                      onDelete: (index) {
                        _portfolioService.deleteEducationItem(index);
                      },
                    ),
                    ExperienceSection(
                      experience: currentData.experience,
                      onUpdate: (index, item) {
                        _portfolioService.updateExperienceItem(index, item);
                      },
                      onDelete: (index) {
                        _portfolioService.deleteExperienceItem(index);
                      },
                    ),
                    WorksSection(
                      works: currentData.works,
                      onDelete: (id) {
                        _portfolioService.deleteWorkItem(id);
                      },
                    ),
                    TestimonialsSection(testimonials: currentData.testimonials),
                    ContactSection(contact: currentData.site.contact),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
