import 'package:flutter/material.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/spacing.dart';
import '../../core/animation/appear.dart';
import '../../shared/layout/responsive_layout.dart';
import '../../shared/widgets/section_layout.dart';
import 'skill_chip.dart';

class SkillsPage extends StatelessWidget {
  const SkillsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionLayout(
      title: 'Skills & Expertise',
      subtitle: 'Technologies and tools I use to bring ideas to life',
      badge: 'WHAT I DO',
      backgroundColor: AppColors.surface.withOpacity(0.3),
      child: const _SkillsGrid(),
    );
  }
}

class _SkillsGrid extends StatelessWidget {
  const _SkillsGrid();

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveLayout.isMobile(context);

    return Column(
      children: [
        _buildSkillCategory(
          title: 'Frontend Development',
          icon: Icons.web_rounded,
          color: AppColors.primary,
          skills: const [
            SkillData('Flutter', 95, Icons.flutter_dash),
            SkillData('React', 90, Icons.javascript),
            SkillData('Vue.js', 85, Icons.code),
            SkillData('TypeScript', 88, Icons.terminal),
            SkillData('HTML/CSS', 95, Icons.html),
            SkillData('Tailwind', 90, Icons.style),
          ],
          isMobile: isMobile,
        ),
        SizedBox(height: isMobile ? AppSpacing.xl : AppSpacing.xxxl),
        _buildSkillCategory(
          title: 'Backend & Database',
          icon: Icons.storage_rounded,
          color: AppColors.accent,
          skills: const [
            SkillData('Node.js', 85, Icons.dns),
            SkillData('Python', 80, Icons.code),
            SkillData('Firebase', 90, Icons.cloud),
            SkillData('MongoDB', 85, Icons.data_object),
            SkillData('PostgreSQL', 82, Icons.storage),
            SkillData('REST API', 90, Icons.api),
          ],
          isMobile: isMobile,
        ),
        SizedBox(height: isMobile ? AppSpacing.xl : AppSpacing.xxxl),
        _buildSkillCategory(
          title: 'Design & Tools',
          icon: Icons.design_services_rounded,
          color: AppColors.cyan,
          skills: const [
            SkillData('Figma', 95, Icons.design_services),
            SkillData('Adobe XD', 88, Icons.edit),
            SkillData('Photoshop', 85, Icons.image),
            SkillData('Illustrator', 82, Icons.brush),
            SkillData('Git', 90, Icons.code_rounded),
            SkillData('Docker', 75, Icons.layers),
          ],
          isMobile: isMobile,
        ),
      ],
    );
  }

  Widget _buildSkillCategory({
    required String title,
    required IconData icon,
    required Color color,
    required List<SkillData> skills,
    required bool isMobile,
  }) {
    return StaggeredAppearAnimation(
      staggerDelay: const Duration(milliseconds: 80),
      children: [
        // Category header
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(AppSpacing.sm),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [color, color.withOpacity(0.6)],
                ),
                borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              ),
              child: Icon(icon, color: AppColors.textPrimary, size: 24),
            ),
            const SizedBox(width: AppSpacing.md),
            Text(
              title,
              style: TextStyle(
                fontSize: isMobile ? 20 : 24,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        
        // Skills grid
        ResponsiveGrid(
          mobileColumns: 1,
          tabletColumns: 2,
          desktopColumns: 3,
          spacing: AppSpacing.md,
          runSpacing: AppSpacing.md,
          children: skills
              .map((skill) => SkillChip(
                    name: skill.name,
                    level: skill.level,
                    icon: skill.icon,
                    color: color,
                  ))
              .toList(),
        ),
      ],
    );
  }
}

class SkillData {
  final String name;
  final int level;
  final IconData icon;

  const SkillData(this.name, this.level, this.icon);
}