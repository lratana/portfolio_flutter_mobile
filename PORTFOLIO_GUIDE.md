# Flutter Portfolio Application

A comprehensive mobile portfolio application built with Flutter that displays professional portfolio information from a JSON file with full CRUD (Create, Read, Update, Delete) functionality.

## Features

### 1. **Data Loading**

- Loads portfolio data from `MyData.json` asset file
- Parses JSON into strongly-typed Dart models
- Real-time data streaming for reactive UI updates

### 2. **Display Sections**

- **Hero Section**: Personal introduction with stats
- **Services/Skills**: Technical expertise overview
- **Skills Section**: Categorized skills with languages
- **Education Timeline**: Educational background with edit/delete
- **Experience Timeline**: Work experience with edit/delete
- **Works/Portfolio**: Project showcase
- **Testimonials**: Professional profile highlights
- **Contact Section**: Contact information and social links

### 3. **CRUD Operations**

#### **READ Operations**

```dart
// Get specific data sections
PortfolioData data = portfolioService.getData();
Hero hero = portfolioService.getHeroData();
Services services = portfolioService.getServicesData();
Skills skills = portfolioService.getSkillsData();
Education education = portfolioService.getEducationData();
Experience experience = portfolioService.getExperienceData();
Works works = portfolioService.getWorksData();
Contact contact = portfolioService.getContactInfo();
```

#### **UPDATE Operations**

```dart
// Update hero section
portfolioService.updateHero(newHeroData);

// Update contact information
portfolioService.updateContact(newContactData);

// Update work item by ID
portfolioService.updateWorkItem(workId, updatedWork);

// Update education item by index
portfolioService.updateEducationItem(index, updatedEducationItem);

// Update experience item by index
portfolioService.updateExperienceItem(index, updatedExperienceItem);
```

#### **DELETE Operations**

```dart
// Delete work item by ID
portfolioService.deleteWorkItem(workId);

// Delete education item by index
portfolioService.deleteEducationItem(index);

// Delete experience item by index
portfolioService.deleteExperienceItem(index);
```

#### **CREATE Operations**

```dart
// Add new work item
portfolioService.addWorkItem(newWorkItem);

// Add new education item
portfolioService.addEducationItem(newEducationItem);

// Add new experience item
portfolioService.addExperienceItem(newExperienceItem);
```

## Project Structure

```
lib/
├── main.dart                          # Main app entry point
├── models/
│   └── portfolio_models.dart         # All data models
├── services/
│   └── portfolio_service.dart        # JSON handling & CRUD operations
└── screens/
    └── [UI components in main.dart]

assets/
└── MyData.json                        # Portfolio data file
```

## Data Models

### Core Models

- `PortfolioData` - Main container for all data
- `Site` - Brand, navigation, and contact info
- `Hero` - Personal introduction and stats
- `Services` - Technical skills summary
- `Skills` - Detailed skill categories
- `Education` - Educational timeline
- `Experience` - Work experience timeline
- `Works` - Portfolio projects
- `Testimonials` - Professional highlights

## Usage Example

```dart
// Initialize service
final portfolioService = PortfolioService();

// Load JSON data
final data = await portfolioService.loadJsonData();

// Listen to data changes
portfolioService.dataStream.listen((updatedData) {
  print('Data updated!');
  setState(() {});
});

// Update education entry
portfolioService.updateEducationItem(0, updatedEducationItem);

// Delete work item
portfolioService.deleteWorkItem('health-system');

// Add new experience
portfolioService.addExperienceItem(newExperienceItem);
```

## UI Components

### HeroSection

Displays personal introduction with avatar, name, tagline, and stats.

### ServicesSection

Shows technical skills in card format with project counts.

### SkillsSection

Displays skills organized by category with chips.

### EducationSection

Shows education timeline with edit/delete functionality.

### ExperienceSection

Displays work experience with edit/delete options.

### WorksSection

Portfolio projects with tags and delete functionality.

### TestimonialsSection

Professional profile highlights and quotes.

### ContactSection

Contact information with social media links.

## Key Features

✅ **Real-time Data Updates** - StreamBuilder integration for reactive UI
✅ **Full CRUD Operations** - Complete data manipulation capabilities
✅ **Model Serialization** - fromJson factory constructors
✅ **Error Handling** - Proper exception handling for data loading
✅ **Edit Dialogs** - In-app editing for education and experience
✅ **Responsive UI** - Mobile-friendly layout
✅ **Modular Architecture** - Separated concerns (models, services, UI)

## Getting Started

1. Ensure `MyData.json` is in the `assets` folder
2. Update `pubspec.yaml` to include assets:

```yaml
flutter:
  assets:
    - MyData.json
```

3. Run the app:

```bash
flutter pub get
flutter run
```

## Available Functions in PortfolioService

### Data Retrieval

- `loadJsonData()` - Load JSON from assets
- `getData()` - Get complete portfolio data
- `getHeroData()` - Get hero section
- `getServicesData()` - Get services
- `getSkillsData()` - Get skills
- `getEducationData()` - Get education
- `getExperienceData()` - Get experience
- `getWorksData()` - Get works
- `getContactInfo()` - Get contact info
- `getBrandInfo()` - Get brand info

### Updates

- `updateHero(Hero)`
- `updateContact(Contact)`
- `updateWorkItem(String, WorkItem)`
- `updateEducationItem(int, EducationItem)`
- `updateExperienceItem(int, ExperienceItem)`

### Deletions

- `deleteWorkItem(String)`
- `deleteEducationItem(int)`
- `deleteExperienceItem(int)`

### Additions

- `addWorkItem(WorkItem)`
- `addEducationItem(EducationItem)`
- `addExperienceItem(ExperienceItem)`

## Notes

- All data operations are performed in-memory
- To persist changes, you would need to implement local storage (SharedPreferences, SQLite, or write back to JSON)
- The service uses StreamController for reactive updates
- All models include fromJson factory constructors for easy JSON parsing
