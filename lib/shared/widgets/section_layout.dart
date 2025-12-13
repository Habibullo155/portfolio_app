import 'package:flutter/material.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/spacing.dart';
import '../../core/theme/typography.dart';
import '../../core/animation/appear.dart';
import '../layout/responsive_layout.dart';

/// Layout для секций страницы
class SectionLayout extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final String? badge;
  final Widget child;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final bool showDivider;
  final CrossAxisAlignment crossAxisAlignment;

  const SectionLayout({
    super.key,
    this.title,
    this.subtitle,
    this.badge,
    required this.child,
    this.backgroundColor,
    this.padding,
    this.showDivider = false,
    this.crossAxisAlignment = CrossAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveLayout.isMobile(context);
    final isTablet = ResponsiveLayout.isTablet(context);

    return Container(
      width: double.infinity,
      color: backgroundColor,
      padding: padding ??
          EdgeInsets.symmetric(
            vertical: isMobile
                ? AppSpacing.sectionVerticalMobile
                : AppSpacing.sectionVertical,
            horizontal: isMobile
                ? AppSpacing.sectionHorizontalMobile
                : isTablet
                    ? AppSpacing.sectionHorizontalTablet
                    : AppSpacing.sectionHorizontal,
          ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppSpacing.maxWidth),
          child: Column(
            crossAxisAlignment: crossAxisAlignment,
            children: [
              if (title != null || subtitle != null) ...[
                _SectionHeader(
                  title: title,
                  subtitle: subtitle,
                  badge: badge,
                  isMobile: isMobile,
                ),
                SizedBox(
                  height: isMobile ? AppSpacing.xl : AppSpacing.xxl,
                ),
              ],
              child,
              if (showDivider) ...[
                SizedBox(
                  height: isMobile ? AppSpacing.xl : AppSpacing.xxl,
                ),
                AppearAnimation(
                  delay: const Duration(milliseconds: 400),
                  child: Container(
                    height: 1,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          AppColors.textTertiary.withOpacity(0.2),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final String? badge;
  final bool isMobile;

  const _SectionHeader({
    this.title,
    this.subtitle,
    this.badge,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (badge != null) ...[
          AppearAnimation(
            offset: const Offset(0, 20),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
              ),
              child: Text(
                badge!.toUpperCase(),
                style: AppTypography.overline.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          ),
          SizedBox(height: isMobile ? AppSpacing.md : AppSpacing.lg),
        ],
        if (title != null)
          AppearAnimation(
            delay: const Duration(milliseconds: 100),
            offset: const Offset(0, 30),
            child: Text(
              title!,
              style: isMobile ? AppTypography.h3 : AppTypography.h2,
            ),
          ),
        if (subtitle != null) ...[
          SizedBox(height: isMobile ? AppSpacing.md : AppSpacing.lg),
          AppearAnimation(
            delay: const Duration(milliseconds: 200),
            offset: const Offset(0, 30),
            child: Text(
              subtitle!,
              style: isMobile ? AppTypography.body2 : AppTypography.body1,
              maxLines: 3,
            ),
          ),
        ],
      ],
    );
  }
}

/// Простая секция с центрированным контентом
class CenteredSection extends StatelessWidget {
  final Widget child;
  final double? maxWidth;

  const CenteredSection({
    super.key,
    required this.child,
    this.maxWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: maxWidth ?? AppSpacing.maxWidth,
        ),
        child: child,
      ),
    );
  }
}

/// Секция с фоновым градиентом
class GradientSection extends StatelessWidget {
  final Widget child;
  final Gradient? gradient;
  final EdgeInsetsGeometry? padding;

  const GradientSection({
    super.key,
    required this.child,
    this.gradient,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveLayout.isMobile(context);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: gradient ??
            LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.primary.withOpacity(0.1),
                AppColors.accent.withOpacity(0.05),
                Colors.transparent,
              ],
            ),
      ),
      padding: padding ??
          EdgeInsets.symmetric(
            vertical: isMobile
                ? AppSpacing.sectionVerticalMobile
                : AppSpacing.sectionVertical,
          ),
      child: child,
    );
  }
}

/// Секция с параллакс эффектом (для фона)
class ParallaxSection extends StatefulWidget {
  final Widget child;
  final Widget? background;
  final double parallaxFactor;

  const ParallaxSection({
    super.key,
    required this.child,
    this.background,
    this.parallaxFactor = 0.5,
  });

  @override
  State<ParallaxSection> createState() => _ParallaxSectionState();
}

class _ParallaxSectionState extends State<ParallaxSection> {
  double _scrollOffset = 0;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is ScrollUpdateNotification) {
          setState(() {
            _scrollOffset = notification.metrics.pixels;
          });
        }
        return false;
      },
      child: Stack(
        children: [
          if (widget.background != null)
            Positioned.fill(
              child: Transform.translate(
                offset: Offset(0, _scrollOffset * widget.parallaxFactor),
                child: widget.background,
              ),
            ),
          widget.child,
        ],
      ),
    );
  }
}