// Portfolio Provider - State management with Riverpod
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/portfolio_models.dart';
import '../services/portfolio_service.dart';

// Portfolio State class
class PortfolioState {
  final PortfolioData? data;
  final bool isLoading;
  final String? errorMessage;

  const PortfolioState({
    this.data,
    this.isLoading = false,
    this.errorMessage,
  });

  bool get hasData => data != null;
  bool get hasError => errorMessage != null;

  // Convenience getters for sections
  PersonalProfile? get hero => data?.hero;
  Services? get services => data?.services;
  Skills? get skills => data?.skills;
  Education? get education => data?.education;
  Experience? get experience => data?.experience;
  Works? get works => data?.works;
  Testimonials? get testimonials => data?.testimonials;
  Contact? get contact => data?.site.contact;
  Brand? get brand => data?.site.brand;

  PortfolioState copyWith({
    PortfolioData? data,
    bool? isLoading,
    String? errorMessage,
  }) {
    return PortfolioState(
      data: data ?? this.data,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}

// Portfolio Notifier
class PortfolioNotifier extends StateNotifier<PortfolioState> {
  final PortfolioService _service = PortfolioService();

  PortfolioNotifier() : super(const PortfolioState()) {
    loadPortfolioData();
  }

  /// Load portfolio data from JSON
  Future<void> loadPortfolioData() async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final data = await _service.loadJsonData();
      state = PortfolioState(data: data, isLoading: false);

      // Listen to service stream for updates
      _service.dataStream.listen((updatedData) {
        state = PortfolioState(data: updatedData, isLoading: false);
      });
    } catch (e) {
      state = PortfolioState(
        isLoading: false,
        errorMessage: 'Failed to load portfolio: $e',
      );
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

// Portfolio Provider - Main provider for the app
final portfolioProvider =
    StateNotifierProvider<PortfolioNotifier, PortfolioState>(
  (ref) => PortfolioNotifier(),
);
