import 'package:flutter/material.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/spacing.dart';
import '../../core/theme/typography.dart';
import '../../core/theme/shadows.dart';
import '../../core/animation/hover_tilt.dart';
import '../../shared/widgets/glass_container.dart';
import 'projects_model.dart';

class ProjectCard extends StatefulWidget {
  final Project project;

  const ProjectCard({
    super.key,
    required this.project,
  });

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return HoverTilt(
      maxTilt: 0.01,
      enableScale: true,
      scaleValue: 1.02,
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: widget.project.color.withOpacity(0.3),
                      blurRadius: 30,
                      spreadRadius: 0,
                      offset: const Offset(0, 10),
                    ),
                  ]
                : AppShadows.card,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildImage(),
                  _buildContent(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImage() {
    return Stack(
      children: [
        // Project image
        AspectRatio(
          aspectRatio: 16 / 10,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            transform: Matrix4.identity()
              ..scale(_isHovered ? 1.05 : 1.0),
            child: Image.asset(
              widget.project.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        widget.project.color,
                        widget.project.color.withOpacity(0.6),
                      ],
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      widget.project.categoryIcon,
                      size: 64,
                      color: AppColors.textPrimary.withOpacity(0.5),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        
        // Overlay gradient
        Positioned.fill(
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity: _isHovered ? 0.8 : 0.3,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.8),
                  ],
                ),
              ),
            ),
          ),
        ),
        
        // Category badge
        Positioned(
          top: AppSpacing.md,
          left: AppSpacing.md,
          child: GlassContainer(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            borderRadius: AppSpacing.radiusFull,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  widget.project.categoryIcon,
                  size: 16,
                  color: widget.project.color,
                ),
                const SizedBox(width: AppSpacing.xs),
                Text(
                  widget.project.categoryName,
                  style: AppTypography.caption.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
        
        // Action buttons (show on hover)
        Positioned(
          top: AppSpacing.md,
          right: AppSpacing.md,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity: _isHovered ? 1.0 : 0.0,
            child: Row(
              children: [
                if (widget.project.githubUrl != null)
                  _buildActionButton(
                    icon: Icons.code_rounded,
                    onTap: () {
                      // Open GitHub URL
                    },
                  ),
                if (widget.project.liveUrl != null) ...[
                  const SizedBox(width: AppSpacing.sm),
                  _buildActionButton(
                    icon: Icons.open_in_new_rounded,
                    onTap: () {
                      // Open live URL
                    },
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: GlassContainer(
        padding: const EdgeInsets.all(AppSpacing.sm),
        borderRadius: AppSpacing.radiusFull,
        child: Icon(
          icon,
          size: 20,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            widget.project.title,
            style: AppTypography.h5.copyWith(
              color: AppColors.textPrimary,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: AppSpacing.sm),
          
          // Description
          Text(
            widget.project.description,
            style: AppTypography.body3.copyWith(
              color: AppColors.textSecondary,
              height: 1.5,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: AppSpacing.md),
          
          // Tags
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: widget.project.tags
                .map((tag) => _buildTag(tag))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTag(String tag) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: widget.project.color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
        border: Border.all(
          color: widget.project.color.withOpacity(0.3),
        ),
      ),
      child: Text(
        tag,
        style: AppTypography.label.copyWith(
          color: widget.project.color,
          fontSize: 11,
        ),
      ),
    );
  }
}

/// Компактная карточка проекта для списка
class CompactProjectCard extends StatelessWidget {
  final Project project;
  final VoidCallback? onTap;

  const CompactProjectCard({
    super.key,
    required this.project,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return HoverLift(
      liftAmount: 4,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            border: Border.all(
              color: AppColors.textTertiary.withOpacity(0.1),
            ),
          ),
          child: Row(
            children: [
              // Image
              ClipRRect(
                borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                child: Image.asset(
                  project.imageUrl,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            project.color,
                            project.color.withOpacity(0.6),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                      ),
                      child: Icon(
                        project.categoryIcon,
                        color: AppColors.textPrimary,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              
              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      project.title,
                      style: AppTypography.h6,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      project.description,
                      style: AppTypography.body3.copyWith(
                        color: AppColors.textSecondary,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              
              // Arrow
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 16,
                color: AppColors.textTertiary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}