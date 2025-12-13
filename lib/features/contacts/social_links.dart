import 'package:flutter/material.dart';
// Добавляем импорт для открытия ссылок
import 'package:url_launcher/url_launcher.dart'; 
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Предполагаемые импорты из вашего проекта:
import '../../core/theme/colors.dart';
import '../../core/theme/spacing.dart';
import '../../core/theme/typography.dart';
import '../../core/animation/appear.dart';
import '../../core/animation/hover_tilt.dart';

/// Класс, описывающий одну социальную ссылку
class SocialLink {
  final String name;
  final IconData icon;
  final String url;
  final Color color;

  const SocialLink({
    required this.name,
    required this.icon,
    required this.url,
    required this.color,
  });
}

/// Основной виджет со списком социальных ссылок
class SocialLinks extends StatelessWidget {
  const SocialLinks({super.key});

  static const List<SocialLink> _socialLinks = [
    SocialLink(
      name: 'GitHub',
      icon: (FontAwesomeIcons.github),
      url: 'https://github.com/Habibullo155/',
      color: Color(0xFF6366F1),
    ),
    SocialLink(
      name: 'LinkedIn',
      icon: (FontAwesomeIcons.linkedin),
      url: 'https://linkedin.com/in/habibullo-zukhurov-921154394', // Исправлена ссылка для корректного открытия
      color: Color(0xFF0A66C2),
    ),
    SocialLink(
      name: 'Telegram',
      icon: (FontAwesomeIcons.telegram),
      url: 'https://t.me/groodsharp',
      color: Color(0xFF1DA1F2),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppearAnimation(
          delay: const Duration(milliseconds: 200),
          child: Text(
            'Connect with me',
            style: AppTypography.h5,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        AppearAnimation(
          delay: const Duration(milliseconds: 300),
          child: Text(
            'Follow me on social media',
            style: AppTypography.body2.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        StaggeredAppearAnimation(
          staggerDelay: const Duration(milliseconds: 100),
          children: _socialLinks.map((link) {
            return Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: _SocialLinkButton(link: link),
            );
          }).toList(),
        ),
      ],
    );
  }
}

/// Кнопка со ссылкой в виде прямоугольника
class _SocialLinkButton extends StatefulWidget {
  final SocialLink link;

  const _SocialLinkButton({required this.link});

  @override
  State<_SocialLinkButton> createState() => _SocialLinkButtonState();
}

class _SocialLinkButtonState extends State<_SocialLinkButton> {
  bool _isHovered = false;
  
  // Функция для открытия URL
  Future<void> _launchUrl() async {
    final Uri url = Uri.parse(widget.link.url);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.platformDefault);
    } else {
      debugPrint('Could not launch ${widget.link.url}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: _launchUrl, // Используем функцию открытия URL
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: _isHovered
                ? widget.link.color.withOpacity(0.1)
                : AppColors.surface,
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            border: Border.all(
              color: _isHovered
                  ? widget.link.color.withOpacity(0.5)
                  : AppColors.textTertiary.withOpacity(0.1),
              width: 1.5,
            ),
          ),
          child: Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.all(AppSpacing.sm),
                decoration: BoxDecoration(
                  color: _isHovered
                      ? widget.link.color
                      : widget.link.color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                ),
                child: Icon(
                  widget.link.icon,
                  color: _isHovered
                      ? AppColors.textPrimary
                      : widget.link.color,
                  size: 20,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Text(
                  widget.link.name,
                  style: AppTypography.body2.copyWith(
                    color: _isHovered
                        ? widget.link.color
                        : AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Icon(
                Icons.arrow_forward_rounded,
                color: _isHovered
                    ? widget.link.color
                    : AppColors.textSecondary,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Компактный вариант - только иконки
class CompactSocialLinks extends StatelessWidget {
  const CompactSocialLinks({super.key});

  static const List<SocialLink> _socialLinks = [
    SocialLink(
      name: 'GitHub',
      icon: Icons.code_rounded,
      url: 'https://github.com',
      color: Color(0xFF6366F1),
    ),
    SocialLink(
      name: 'LinkedIn',
      icon: Icons.work_rounded,
      url: 'https://linkedin.com',
      color: Color(0xFF0A66C2),
    ),
    SocialLink(
      name: 'Twitter',
      icon: Icons.chat_rounded,
      url: 'https://twitter.com',
      color: Color(0xFF1DA1F2),
    ),
    SocialLink(
      name: 'Dribbble',
      icon: Icons.brush_rounded,
      url: 'https://dribbble.com',
      color: Color(0xFFEA4C89),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _socialLinks.map((link) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
          child: _CompactSocialIcon(link: link),
        );
      }).toList(),
    );
  }
}

/// Иконка со ссылкой в компактном варианте
class _CompactSocialIcon extends StatefulWidget {
  final SocialLink link;

  const _CompactSocialIcon({required this.link});

  @override
  State<_CompactSocialIcon> createState() => _CompactSocialIconState();
}

class _CompactSocialIconState extends State<_CompactSocialIcon> {
  bool _isHovered = false;

  // Функция для открытия URL
  Future<void> _launchUrl() async {
    final Uri url = Uri.parse(widget.link.url);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.platformDefault);
    } else {
      debugPrint('Could not launch ${widget.link.url}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: _launchUrl, // Используем функцию открытия URL
        child: HoverTilt(
          maxTilt: 0.05,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              gradient: _isHovered
                  ? LinearGradient(
                      colors: [
                        widget.link.color,
                        widget.link.color.withOpacity(0.6),
                      ],
                    )
                  : null,
              color: _isHovered ? null : AppColors.surface,
              shape: BoxShape.circle,
              border: Border.all(
                color: _isHovered
                    ? Colors.transparent
                    : AppColors.textTertiary.withOpacity(0.2),
              ),
              boxShadow: _isHovered
                  ? [
                      BoxShadow(
                        color: widget.link.color.withOpacity(0.4),
                        blurRadius: 20,
                        spreadRadius: 2,
                      ),
                    ]
                  : null,
            ),
            child: Icon(
              widget.link.icon,
              color: _isHovered
                  ? AppColors.textPrimary
                  : AppColors.textSecondary,
              size: 24,
            ),
          ),
        ),
      ),
    );
  }
}