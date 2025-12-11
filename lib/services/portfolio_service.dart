// Service for handling portfolio data - JSON Read/Update/Delete operations
import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/portfolio_models.dart';

class PortfolioService {
  static final PortfolioService _instance = PortfolioService._internal();

  late PortfolioData portfolioData;
  final StreamController<PortfolioData> _dataController =
      StreamController<PortfolioData>.broadcast();

  PortfolioService._internal();

  factory PortfolioService() {
    return _instance;
  }

  // Get data stream
  Stream<PortfolioData> get dataStream => _dataController.stream;

  /// Load JSON data from assets
  Future<PortfolioData> loadJsonData() async {
    try {
      final jsonString = await rootBundle.loadString('assets/MyData.json');
      final jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;
      portfolioData = PortfolioData.fromJson(jsonMap);
      _dataController.add(portfolioData);
      print(
          'Portfolio JSON data loaded successfully.${portfolioData.site.brand.name}');
      return portfolioData;
    } catch (e) {
      throw Exception('Failed to load JSON data: $e');
    }
  }

  /// Get all portfolio data
  PortfolioData getData() {
    return portfolioData;
  }

  /// Get hero section data
  PersonalProfile getHeroData() {
    return portfolioData.hero;
  }

  /// Get services data
  Services getServicesData() {
    return portfolioData.services;
  }

  /// Get skills data
  Skills getSkillsData() {
    return portfolioData.skills;
  }

  /// Get education data
  Education getEducationData() {
    return portfolioData.education;
  }

  /// Get experience data
  Experience getExperienceData() {
    return portfolioData.experience;
  }

  /// Get works data
  Works getWorksData() {
    return portfolioData.works;
  }

  /// Get contact information
  Contact getContactInfo() {
    return portfolioData.site.contact;
  }

  /// Get brand information
  Brand getBrandInfo() {
    return portfolioData.site.brand;
  }

  // --- UPDATE OPERATIONS ---

  /// Dynamic update helper - Updates portfolio data and notifies listeners
  void _updatePortfolioData({
    Site? site,
    PersonalProfile? hero,
    Services? services,
    Skills? skills,
    Education? education,
    Experience? experience,
    Works? works,
    Testimonials? testimonials,
  }) {
    portfolioData = PortfolioData(
      site: site ?? portfolioData.site,
      hero: hero ?? portfolioData.hero,
      services: services ?? portfolioData.services,
      skills: skills ?? portfolioData.skills,
      education: education ?? portfolioData.education,
      experience: experience ?? portfolioData.experience,
      works: works ?? portfolioData.works,
      testimonials: testimonials ?? portfolioData.testimonials,
    );
    _dataController.add(portfolioData);
  }

  /// Update hero section data
  void updateHero(PersonalProfile newHero) {
    _updatePortfolioData(hero: newHero);
    print('✓ Hero data updated');
  }

  /// Update contact information
  void updateContact(Contact newContact) {
    final updatedSite = Site(
      brand: portfolioData.site.brand,
      navigation: portfolioData.site.navigation,
      contact: newContact,
    );
    _updatePortfolioData(site: updatedSite);
    print('✓ Contact info updated');
  }

  /// Update a work item by ID
  void updateWorkItem(String workId, WorkItem updatedWork) {
    final updatedItems = portfolioData.works.items
        .map((work) => work.id == workId ? updatedWork : work)
        .toList();

    final updatedWorks = Works(
      title: portfolioData.works.title,
      note: portfolioData.works.note,
      items: updatedItems,
    );
    _updatePortfolioData(works: updatedWorks);
    print('✓ Work item updated: $workId');
  }

  /// Update an education item by index
  void updateEducationItem(int index, EducationItem updatedItem) {
    if (index < 0 || index >= portfolioData.education.timeline.length) return;

    final updatedTimeline =
        List<EducationItem>.from(portfolioData.education.timeline);
    updatedTimeline[index] = updatedItem;

    final updatedEducation = Education(
      title: portfolioData.education.title,
      timeline: updatedTimeline,
    );
    _updatePortfolioData(education: updatedEducation);
    print('✓ Education item updated at index $index');
  }

  /// Update an experience item by index
  void updateExperienceItem(int index, ExperienceItem updatedItem) {
    if (index < 0 || index >= portfolioData.experience.timeline.length) return;

    final updatedTimeline =
        List<ExperienceItem>.from(portfolioData.experience.timeline);
    updatedTimeline[index] = updatedItem;

    final updatedExperience = Experience(
      title: portfolioData.experience.title,
      timeline: updatedTimeline,
    );
    _updatePortfolioData(experience: updatedExperience);
    print('✓ Experience item updated at index $index');
  }

  // --- DELETE OPERATIONS ---

  /// Delete a work item by ID
  void deleteWorkItem(String workId) {
    final updatedItems =
        portfolioData.works.items.where((work) => work.id != workId).toList();

    final updatedWorks = Works(
      title: portfolioData.works.title,
      note: portfolioData.works.note,
      items: updatedItems,
    );
    _updatePortfolioData(works: updatedWorks);
    print('✓ Work item deleted: $workId');
  }

  /// Delete an education item by index
  void deleteEducationItem(int index) {
    if (index < 0 || index >= portfolioData.education.timeline.length) return;

    final updatedTimeline =
        List<EducationItem>.from(portfolioData.education.timeline);
    updatedTimeline.removeAt(index);

    final updatedEducation = Education(
      title: portfolioData.education.title,
      timeline: updatedTimeline,
    );
    _updatePortfolioData(education: updatedEducation);
    print('✓ Education item deleted at index $index');
  }

  /// Delete an experience item by index
  void deleteExperienceItem(int index) {
    if (index < 0 || index >= portfolioData.experience.timeline.length) return;

    final updatedTimeline =
        List<ExperienceItem>.from(portfolioData.experience.timeline);
    updatedTimeline.removeAt(index);

    final updatedExperience = Experience(
      title: portfolioData.experience.title,
      timeline: updatedTimeline,
    );
    _updatePortfolioData(experience: updatedExperience);
    print('✓ Experience item deleted at index $index');
  }

  /// Add a new work item
  void addWorkItem(WorkItem newWork) {
    final updatedItems = [...portfolioData.works.items, newWork];

    final updatedWorks = Works(
      title: portfolioData.works.title,
      note: portfolioData.works.note,
      items: updatedItems,
    );
    _updatePortfolioData(works: updatedWorks);
    print('✓ New work item added: ${newWork.title}');
  }

  /// Add a new education item
  void addEducationItem(EducationItem newItem) {
    final updatedTimeline = [...portfolioData.education.timeline, newItem];

    final updatedEducation = Education(
      title: portfolioData.education.title,
      timeline: updatedTimeline,
    );
    _updatePortfolioData(education: updatedEducation);
    print('✓ New education item added: ${newItem.institution}');
  }

  /// Add a new experience item
  void addExperienceItem(ExperienceItem newItem) {
    final updatedTimeline = [...portfolioData.experience.timeline, newItem];

    final updatedExperience = Experience(
      title: portfolioData.experience.title,
      timeline: updatedTimeline,
    );
    _updatePortfolioData(experience: updatedExperience);
    print('✓ New experience item added: ${newItem.company}');
  }

  void dispose() {
    _dataController.close();
  }
}
