// Data Models for Portfolio Application
class PortfolioData {
  final Site site;
  final PersonalProfile hero;
  final Services services;
  final Skills skills;
  final Education education;
  final Experience experience;
  final Works works;
  final Testimonials testimonials;

  PortfolioData({
    required this.site,
    required this.hero,
    required this.services,
    required this.skills,
    required this.education,
    required this.experience,
    required this.works,
    required this.testimonials,
  });

  factory PortfolioData.fromJson(Map<String, dynamic> json) {
    return PortfolioData(
      site: Site.fromJson(json['site'] ?? {}),
      hero: PersonalProfile.fromJson(json['hero'] ?? {}),
      services: Services.fromJson(json['services'] ?? {}),
      skills: Skills.fromJson(json['skills'] ?? {}),
      education: Education.fromJson(json['education'] ?? {}),
      experience: Experience.fromJson(json['experience'] ?? {}),
      works: Works.fromJson(json['works'] ?? {}),
      testimonials: Testimonials.fromJson(json['testimonials'] ?? {}),
    );
  }
}

class Site {
  final Brand brand;
  final List<Navigation> navigation;
  final Contact contact;

  Site({
    required this.brand,
    required this.navigation,
    required this.contact,
  });

  factory Site.fromJson(Map<String, dynamic> json) {
    return Site(
      brand: Brand.fromJson(json['brand'] ?? {}),
      navigation: (json['navigation'] as List<dynamic>?)
              ?.map((e) => Navigation.fromJson(e))
              .toList() ??
          [],
      contact: Contact.fromJson(json['contact'] ?? {}),
    );
  }
}

class Brand {
  final String name;
  final String logo;

  Brand({required this.name, required this.logo});

  factory Brand.fromJson(Map<String, dynamic> json) {
    return Brand(
      name: json['name'] ?? '',
      logo: json['logo'] ?? '',
    );
  }
}

class Navigation {
  final String label;
  final String to;

  Navigation({required this.label, required this.to});

  factory Navigation.fromJson(Map<String, dynamic> json) {
    return Navigation(
      label: json['label'] ?? '',
      to: json['to'] ?? '',
    );
  }
}

class Contact {
  final String email;
  final String phone;
  final String location;
  final Social social;

  Contact({
    required this.email,
    required this.phone,
    required this.location,
    required this.social,
  });

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      location: json['location'] ?? '',
      social: Social.fromJson(json['social'] ?? {}),
    );
  }
}

class Social {
  final String linkedin;
  final String twitter;
  final String github;
  final String dribbble;
  final String behance;

  Social({
    required this.linkedin,
    required this.twitter,
    required this.github,
    required this.dribbble,
    required this.behance,
  });

  factory Social.fromJson(Map<String, dynamic> json) {
    return Social(
      linkedin: json['linkedin'] ?? '',
      twitter: json['twitter'] ?? '',
      github: json['github'] ?? '',
      dribbble: json['dribbble'] ?? '',
      behance: json['behance'] ?? '',
    );
  }
}

class PersonalProfile {
  final String greeting;
  final String name;
  final String tagline;
  final String bio;
  final String avatar;
  final String email;
  final int yearsExperience;
  final Certification certification;
  final List<Stat> stats;

  PersonalProfile({
    required this.greeting,
    required this.name,
    required this.tagline,
    required this.bio,
    required this.avatar,
    required this.email,
    required this.yearsExperience,
    required this.certification,
    required this.stats,
  });

  factory PersonalProfile.fromJson(Map<String, dynamic> json) {
    return PersonalProfile(
      greeting: json['greeting'] ?? '',
      name: json['name'] ?? '',
      tagline: json['tagline'] ?? '',
      bio: json['bio'] ?? '',
      avatar: json['avatar'] ?? '',
      email: json['email'] ?? '',
      yearsExperience: json['yearsExperience'] ?? 0,
      certification: Certification.fromJson(json['certification'] ?? {}),
      stats: (json['stats'] as List<dynamic>?)
              ?.map((e) => Stat.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class Certification {
  final String title;
  final String badge;

  Certification({required this.title, required this.badge});

  factory Certification.fromJson(Map<String, dynamic> json) {
    return Certification(
      title: json['title'] ?? '',
      badge: json['badge'] ?? '',
    );
  }
}

class Stat {
  final String label;
  final int value;
  final String suffix;

  Stat({required this.label, required this.value, required this.suffix});

  factory Stat.fromJson(Map<String, dynamic> json) {
    return Stat(
      label: json['label'] ?? '',
      value: json['value'] ?? 0,
      suffix: json['suffix'] ?? '',
    );
  }
}

class Services {
  final String title;
  final List<Service> items;

  Services({required this.title, required this.items});

  factory Services.fromJson(Map<String, dynamic> json) {
    return Services(
      title: json['title'] ?? '',
      items: (json['items'] as List<dynamic>?)
              ?.map((e) => Service.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class Service {
  final String id;
  final String title;
  final String description;
  final int projects;
  final String icon;

  Service({
    required this.id,
    required this.title,
    required this.description,
    required this.projects,
    required this.icon,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      projects: json['projects'] ?? 0,
      icon: json['icon'] ?? '',
    );
  }
}

class Skills {
  final String title;
  final List<SkillCategory> categories;
  final Map<String, String> languages;

  Skills({
    required this.title,
    required this.categories,
    required this.languages,
  });

  factory Skills.fromJson(Map<String, dynamic> json) {
    return Skills(
      title: json['title'] ?? '',
      categories: (json['categories'] as List<dynamic>?)
              ?.map((e) => SkillCategory.fromJson(e))
              .toList() ??
          [],
      languages: Map<String, String>.from(json['languages'] ?? {}),
    );
  }
}

class SkillCategory {
  final String name;
  final List<String> skills;

  SkillCategory({required this.name, required this.skills});

  factory SkillCategory.fromJson(Map<String, dynamic> json) {
    return SkillCategory(
      name: json['name'] ?? '',
      skills: List<String>.from(json['skills'] ?? []),
    );
  }
}

class Education {
  final String title;
  final List<EducationItem> timeline;

  Education({required this.title, required this.timeline});

  factory Education.fromJson(Map<String, dynamic> json) {
    return Education(
      title: json['title'] ?? '',
      timeline: (json['timeline'] as List<dynamic>?)
              ?.map((e) => EducationItem.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class EducationItem {
  final String year;
  final String institution;
  final String degree;
  final String description;

  EducationItem({
    required this.year,
    required this.institution,
    required this.degree,
    required this.description,
  });

  factory EducationItem.fromJson(Map<String, dynamic> json) {
    return EducationItem(
      year: json['year'] ?? '',
      institution: json['institution'] ?? '',
      degree: json['degree'] ?? '',
      description: json['description'] ?? '',
    );
  }
}

class Experience {
  final String title;
  final List<ExperienceItem> timeline;

  Experience({required this.title, required this.timeline});

  factory Experience.fromJson(Map<String, dynamic> json) {
    return Experience(
      title: json['title'] ?? '',
      timeline: (json['timeline'] as List<dynamic>?)
              ?.map((e) => ExperienceItem.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class ExperienceItem {
  final String company;
  final String location;
  final String period;
  final List<Role> roles;

  ExperienceItem({
    required this.company,
    required this.location,
    required this.period,
    required this.roles,
  });

  factory ExperienceItem.fromJson(Map<String, dynamic> json) {
    return ExperienceItem(
      company: json['company'] ?? '',
      location: json['location'] ?? '',
      period: json['period'] ?? '',
      roles: (json['roles'] as List<dynamic>?)
              ?.map((e) => Role.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class Role {
  final String title;
  final String summary;
  final List<String> highlights;

  Role({
    required this.title,
    required this.summary,
    required this.highlights,
  });

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      title: json['title'] ?? '',
      summary: json['summary'] ?? '',
      highlights: List<String>.from(json['highlights'] ?? []),
    );
  }
}

class Works {
  final String title;
  final String note;
  final List<WorkItem> items;

  Works({required this.title, required this.note, required this.items});

  factory Works.fromJson(Map<String, dynamic> json) {
    return Works(
      title: json['title'] ?? '',
      note: json['note'] ?? '',
      items: (json['items'] as List<dynamic>?)
              ?.map((e) => WorkItem.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class WorkItem {
  final String id;
  final String title;
  final String subtitle;
  final String cover;
  final String grid;
  final List<String> tags;
  final String url;
  final String caseStudy;

  WorkItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.cover,
    required this.grid,
    required this.tags,
    required this.url,
    required this.caseStudy,
  });

  factory WorkItem.fromJson(Map<String, dynamic> json) {
    return WorkItem(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      subtitle: json['subtitle'] ?? '',
      cover: json['cover'] ?? '',
      grid: json['grid'] ?? '',
      tags: List<String>.from(json['tags'] ?? []),
      url: json['url'] ?? '',
      caseStudy: json['caseStudy'] ?? '',
    );
  }
}

class Testimonials {
  final String title;
  final List<Testimonial> items;

  Testimonials({required this.title, required this.items});

  factory Testimonials.fromJson(Map<String, dynamic> json) {
    return Testimonials(
      title: json['title'] ?? '',
      items: (json['items'] as List<dynamic>?)
              ?.map((e) => Testimonial.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class Testimonial {
  final String name;
  final String role;
  final String company;
  final String avatar;
  final String quote;

  Testimonial({
    required this.name,
    required this.role,
    required this.company,
    required this.avatar,
    required this.quote,
  });

  factory Testimonial.fromJson(Map<String, dynamic> json) {
    return Testimonial(
      name: json['name'] ?? '',
      role: json['role'] ?? '',
      company: json['company'] ?? '',
      avatar: json['avatar'] ?? '',
      quote: json['quote'] ?? '',
    );
  }
}
