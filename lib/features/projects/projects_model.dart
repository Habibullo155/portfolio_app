import 'package:flutter/material.dart';

/// Категории проектов
enum ProjectCategory {
  mobile,
  web,
  design,
  all,
}

/// Модель проекта
class Project {
  final String title;
  final String description;
  final String imageUrl;
  final List<String> tags;
  final ProjectCategory category;
  final Color color;
  final String? liveUrl;
  final String? githubUrl;
  final DateTime? completedDate;
  final List<String>? features;

  const Project({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.tags,
    required this.category,
    required this.color,
    this.liveUrl,
    this.githubUrl,
    this.completedDate,
    this.features,
  });

  String get categoryName {
    switch (category) {
      case ProjectCategory.mobile:
        return 'Mobile App';
      case ProjectCategory.web:
        return 'Web App';
      case ProjectCategory.design:
        return 'Design';
      case ProjectCategory.all:
        return 'All';
    }
  }

  IconData get categoryIcon {
    switch (category) {
      case ProjectCategory.mobile:
        return Icons.smartphone_rounded;
      case ProjectCategory.web:
        return Icons.web_rounded;
      case ProjectCategory.design:
        return Icons.design_services_rounded;
      case ProjectCategory.all:
        return Icons.apps_rounded;
    }
  }
}

/// Extension для работы с категориями
extension ProjectCategoryExtension on ProjectCategory {
  String get displayName {
    switch (this) {
      case ProjectCategory.mobile:
        return 'Mobile';
      case ProjectCategory.web:
        return 'Web';
      case ProjectCategory.design:
        return 'Design';
      case ProjectCategory.all:
        return 'All';
    }
  }

  IconData get icon {
    switch (this) {
      case ProjectCategory.mobile:
        return Icons.smartphone_rounded;
      case ProjectCategory.web:
        return Icons.web_rounded;
      case ProjectCategory.design:
        return Icons.design_services_rounded;
      case ProjectCategory.all:
        return Icons.apps_rounded;
    }
  }
}