import 'package:flutter/material.dart';
import '../../core/theme/spacing.dart';
import '../../core/animation/appear.dart';
import '../../shared/layout/responsive_layout.dart';
import '../../shared/widgets/section_layout.dart';
import 'projects_model.dart';
import 'projects_card.dart';

class ProjectsPage extends StatelessWidget {
  const ProjectsPage({super.key});

  static final List<Project> _projects = [
    Project(
      title: 'E-Commerce Mobile App',
      description: 'A modern e-commerce application built with Flutter featuring real-time inventory, secure payments, and beautiful UI/UX.',
      imageUrl: 'assets/project1.jpg',
      tags: ['Flutter', 'Firebase', 'Stripe'],
      category: ProjectCategory.mobile,
      color: const Color(0xFF6366F1),
    ),
    Project(
      title: 'Social Media Dashboard',
      description: 'Analytics dashboard for social media management with real-time data visualization and multi-platform integration.',
      imageUrl: 'assets/project2.jpg',
      tags: ['React', 'Node.js', 'MongoDB'],
      category: ProjectCategory.web,
      color: const Color(0xFFA855F7),
    ),
    Project(
      title: 'AI Photo Editor',
      description: 'Intelligent photo editing app with AI-powered filters, object removal, and enhancement features.',
      imageUrl: 'assets/project3.jpg',
      tags: ['Flutter', 'TensorFlow', 'Python'],
      category: ProjectCategory.mobile,
      color: const Color(0xFF06B6D4),
    ),
    Project(
      title: 'Task Management Platform',
      description: 'Collaborative task management system with team features, time tracking, and project analytics.',
      imageUrl: 'assets/project4.jpg',
      tags: ['Vue.js', 'PostgreSQL', 'Docker'],
      category: ProjectCategory.web,
      color: const Color(0xFFEC4899),
    ),
    Project(
      title: 'Fitness Tracking App',
      description: 'Comprehensive fitness tracking application with workout plans, nutrition tracking, and progress analytics.',
      imageUrl: 'assets/project1.jpg',
      tags: ['Flutter', 'HealthKit', 'Charts'],
      category: ProjectCategory.mobile,
      color: const Color(0xFF10B981),
    ),
    Project(
      title: 'Real Estate Portal',
      description: 'Property listing and management platform with virtual tours, mortgage calculator, and agent matching.',
      imageUrl: 'assets/project2.jpg',
      tags: ['React', 'GraphQL', 'AWS'],
      category: ProjectCategory.web,
      color: const Color(0xFFF59E0B),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SectionLayout(
      title: 'Featured Projects',
      subtitle: 'A collection of my recent work and passion projects',
      badge: 'PORTFOLIO',
      child: const _ProjectsGrid(),
    );
  }
}

class _ProjectsGrid extends StatefulWidget {
  const _ProjectsGrid();

  @override
  State<_ProjectsGrid> createState() => _ProjectsGridState();
}

class _ProjectsGridState extends State<_ProjectsGrid> {
  ProjectCategory? _selectedCategory;

  List<Project> get _filteredProjects {
    if (_selectedCategory == null) {
      return ProjectsPage._projects;
    }
    return ProjectsPage._projects
        .where((project) => project.category == _selectedCategory)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveLayout.isMobile(context);

    return Column(
      children: [
        // Filter tabs
        AppearAnimation(
          delay: const Duration(milliseconds: 200),
          child: _buildFilterTabs(isMobile),
        ),
        SizedBox(height: isMobile ? AppSpacing.xl : AppSpacing.xxxl),
        
        // Projects grid
        StaggeredAppearAnimation(
          staggerDelay: const Duration(milliseconds: 100),
          children: [
            ResponsiveGrid(
              mobileColumns: 1,
              tabletColumns: 2,
              desktopColumns: 2,
              spacing: AppSpacing.cardGap,
              runSpacing: AppSpacing.cardGap,
              children: _filteredProjects
                  .map((project) => ProjectCard(project: project))
                  .toList(),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFilterTabs(bool isMobile) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: isMobile ? MainAxisAlignment.start : MainAxisAlignment.center,
        children: [
          _buildFilterChip('All', null, isMobile),
          const SizedBox(width: AppSpacing.sm),
          _buildFilterChip('Mobile', ProjectCategory.mobile, isMobile),
          const SizedBox(width: AppSpacing.sm),
          _buildFilterChip('Web', ProjectCategory.web, isMobile),
          const SizedBox(width: AppSpacing.sm),
          _buildFilterChip('Design', ProjectCategory.design, isMobile),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, ProjectCategory? category, bool isMobile) {
    final isSelected = _selectedCategory == category;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCategory = category;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? AppSpacing.md : AppSpacing.lg,
          vertical: isMobile ? AppSpacing.sm : AppSpacing.md,
        ),
        decoration: BoxDecoration(
          gradient: isSelected
              ? const LinearGradient(
                  colors: [Color(0xFF6366F1), Color(0xFFA855F7)],
                )
              : null,
          color: isSelected ? null : Colors.transparent,
          borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
          border: Border.all(
            color: isSelected
                ? Colors.transparent
                : const Color(0xFF71717A).withOpacity(0.3),
            width: 1.5,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: isMobile ? 14 : 16,
            fontWeight: FontWeight.w600,
            color: isSelected
                ? const Color(0xFFFAFAFA)
                : const Color(0xFFA1A1AA),
          ),
        ),
      ),
    );
  }
}