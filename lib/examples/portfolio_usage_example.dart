// Example usage of Portfolio Service CRUD Operations

import 'package:sample_project/services/portfolio_service.dart';
import 'package:sample_project/models/portfolio_models.dart';

void main() async {
  final service = PortfolioService();

  // ==================== READ OPERATIONS ====================

  // Load JSON data from assets
  final portfolioData = await service.loadJsonData();
  print('Loaded portfolio data: ${portfolioData.site.brand.name}');

  // Get specific sections
  final hero = service.getHeroData();
  print('Name: ${hero.name}');
  print('Tagline: ${hero.tagline}');

  final services = service.getServicesData();
  print('Services: ${services.items.length} items');

  final skills = service.getSkillsData();
  print('Skill categories: ${skills.categories.length}');

  final education = service.getEducationData();
  print('Education items: ${education.timeline.length}');

  final experience = service.getExperienceData();
  print('Experience items: ${experience.timeline.length}');

  final works = service.getWorksData();
  print('Works: ${works.items.length} projects');

  final contact = service.getContactInfo();
  print('Email: ${contact.email}');
  print('Phone: ${contact.phone}');

  // Listen to data changes
  service.dataStream.listen((updatedData) {
    print('Portfolio data updated!');
    print('Total works: ${updatedData.works.items.length}');
  });

  // ==================== UPDATE OPERATIONS ====================

  // Update a work item
  if (works.items.isNotEmpty) {
    final firstWork = works.items.first;
    final updatedWork = WorkItem(
      id: firstWork.id,
      title: 'Updated: ${firstWork.title}',
      subtitle: firstWork.subtitle,
      cover: firstWork.cover,
      grid: firstWork.grid,
      tags: [...firstWork.tags, 'updated'],
      url: firstWork.url,
      caseStudy: firstWork.caseStudy,
    );
    service.updateWorkItem(firstWork.id, updatedWork);
  }

  // Update an education item
  if (education.timeline.isNotEmpty) {
    final firstEdu = education.timeline.first;
    final updatedEdu = EducationItem(
      year: '2024',
      institution: firstEdu.institution,
      degree: 'Updated ${firstEdu.degree}',
      description: firstEdu.description,
    );
    service.updateEducationItem(0, updatedEdu);
  }

  // Update an experience item
  if (experience.timeline.isNotEmpty) {
    final firstExp = experience.timeline.first;
    final updatedExp = ExperienceItem(
      company: firstExp.company,
      location: firstExp.location,
      period: '2024 - Present',
      roles: firstExp.roles,
    );
    service.updateExperienceItem(0, updatedExp);
  }

  // Update hero data
  final updatedHero = PersonalProfile(
    greeting: hero.greeting,
    name: hero.name,
    tagline: 'Updated: ${hero.tagline}',
    bio: hero.bio,
    avatar: hero.avatar,
    email: hero.email,
    yearsExperience: hero.yearsExperience + 1,
    certification: hero.certification,
    stats: hero.stats,
  );
  service.updateHero(updatedHero);

  // ==================== CREATE OPERATIONS ====================

  // Add a new work item
  final newWork = WorkItem(
    id: 'new-project',
    title: 'New Portfolio Project',
    subtitle: 'Flutter Mobile App',
    cover: '/images/works/new-project.png',
    grid: 'standard',
    tags: ['Flutter', 'Mobile', 'New'],
    url: '#',
    caseStudy: '#',
  );
  service.addWorkItem(newWork);

  // Add a new education item
  final newEducation = EducationItem(
    year: '2024',
    institution: 'Online Academy',
    degree: 'Advanced Flutter Development',
    description: 'Completed advanced course in Flutter development',
  );
  service.addEducationItem(newEducation);

  // Add a new experience item
  final newExperience = ExperienceItem(
    company: 'New Tech Company',
    location: 'Remote',
    period: '2024 - Present',
    roles: [
      Role(
        title: 'Senior Developer',
        summary: 'Leading development team',
        highlights: ['Feature development', 'Team management'],
      ),
    ],
  );
  service.addExperienceItem(newExperience);

  // ==================== DELETE OPERATIONS ====================

  // Delete a work item by ID
  service.deleteWorkItem('mobile-app');

  // Delete an education item by index
  service.deleteEducationItem(0);

  // Delete an experience item by index
  service.deleteExperienceItem(0);

  // ==================== VERIFY CHANGES ====================

  // Get updated data
  final updatedData = service.getData();
  print('\n=== Final Results ===');
  print('Total works: ${updatedData.works.items.length}');
  print('Total education items: ${updatedData.education.timeline.length}');
  print('Total experience items: ${updatedData.experience.timeline.length}');
  print('Hero name: ${updatedData.hero.name}');

  // Clean up
  service.dispose();
}

/*
Expected Output:
Loaded portfolio data: LONG RATANA
Name: LONG RATANA
Tagline: Full-stack developer building innovative web and mobile solutions.
Services: 3 items
Skill categories: 7
Education items: 5
Experience items: 4
Works: 3 projects
Email: lratana85@gmail.com
Phone: (+855) 96 72 75 814

Portfolio data updated!
Total works: 4 (after adding new work)

Portfolio data updated!
Total works: 3 (after deleting work)

=== Final Results ===
Total works: 3
Total education items: 4 (after deleting one)
Total experience items: 3 (after deleting one)
Hero name: LONG RATANA
*/
