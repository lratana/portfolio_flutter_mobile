// Portfolio Provider - State management with ChangeNotifier
import 'package:flutter/foundation.dart';
import '../models/portfolio_models.dart';
import '../services/portfolio_service.dart';

class PortfolioProvider extends ChangeNotifier {
  final PortfolioService _service = PortfolioService();

  PortfolioData? _portfolioData;
  bool _isLoading = false;
  String? _errorMessage;

  // Getters
  PortfolioData? get portfolioData => _portfolioData;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get hasData => _portfolioData != null;
  bool get hasError => _errorMessage != null;

  // Get specific sections
  PersonalProfile? get hero => _portfolioData?.hero;
  Services? get services => _portfolioData?.services;
  Skills? get skills => _portfolioData?.skills;
  Education? get education => _portfolioData?.education;
  Experience? get experience => _portfolioData?.experience;
  Works? get works => _portfolioData?.works;
  Testimonials? get testimonials => _portfolioData?.testimonials;
  Contact? get contact => _portfolioData?.site.contact;
  Brand? get brand => _portfolioData?.site.brand;

  /// Load portfolio data from JSON
  Future<void> loadPortfolioData() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _portfolioData = await _service.loadJsonData();
      _isLoading = false;
      notifyListeners();

      // Listen to service stream for updates
      _service.dataStream.listen((updatedData) {
        _portfolioData = updatedData;
        notifyListeners();
      });
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'Failed to load portfolio: $e';
      notifyListeners();
    }
  }

  // ==================== UPDATE OPERATIONS ====================

  /// Update hero section
  void updateHero(PersonalProfile newHero) {
    _service.updateHero(newHero);
  }

  /// Update contact information
  void updateContact(Contact newContact) {
    _service.updateContact(newContact);
  }

  /// Update a work item by ID
  void updateWorkItem(String workId, WorkItem updatedWork) {
    _service.updateWorkItem(workId, updatedWork);
  }

  /// Update an education item by index
  void updateEducationItem(int index, EducationItem updatedItem) {
    _service.updateEducationItem(index, updatedItem);
  }

  /// Update an experience item by index
  void updateExperienceItem(int index, ExperienceItem updatedItem) {
    _service.updateExperienceItem(index, updatedItem);
  }

  // ==================== CREATE OPERATIONS ====================

  /// Add a new work item
  void addWorkItem(WorkItem newWork) {
    _service.addWorkItem(newWork);
  }

  /// Add a new education item
  void addEducationItem(EducationItem newItem) {
    _service.addEducationItem(newItem);
  }

  /// Add a new experience item
  void addExperienceItem(ExperienceItem newItem) {
    _service.addExperienceItem(newItem);
  }

  // ==================== DELETE OPERATIONS ====================

  /// Delete a work item by ID
  void deleteWorkItem(String workId) {
    _service.deleteWorkItem(workId);
  }

  /// Delete an education item by index
  void deleteEducationItem(int index) {
    _service.deleteEducationItem(index);
  }

  /// Delete an experience item by index
  void deleteExperienceItem(int index) {
    _service.deleteExperienceItem(index);
  }

  @override
  void dispose() {
    _service.dispose();
    super.dispose();
  }
}
