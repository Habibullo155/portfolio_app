import 'package:flutter/material.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/spacing.dart';
import '../../core/theme/typography.dart';
import '../../core/animation/appear.dart';
import '../../core/animation/hover_tilt.dart';
import '../../shared/layout/responsive_layout.dart';
import '../../shared/widgets/primary_button.dart';
import '../../shared/widgets/glass_container.dart';
import 'dart:math' as math;

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  late AnimationController _floatController;

  @override
  void initState() {
    super.initState();
    _floatController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _floatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveLayout.isMobile(context);
    final isTablet = ResponsiveLayout.isTablet(context);
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: double.infinity,
      height: screenHeight,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.background,
            AppColors.primary.withOpacity(0.05),
            AppColors.accent.withOpacity(0.05),
            AppColors.background,
          ],
          stops: const [0.0, 0.3, 0.7, 1.0],
        ),
      ),
      child: Stack(
        children: [
          // Animated background elements
          ..._buildBackgroundElements(),
          
          // Main content
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile
                    ? AppSpacing.sectionHorizontalMobile
                    : isTablet
                        ? AppSpacing.sectionHorizontalTablet
                        : AppSpacing.sectionHorizontal,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: AppSpacing.maxWidth),
                  child: isMobile
                      ? _buildMobileLayout()
                      : _buildDesktopLayout(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildProfileImage(size: 180),
        const SizedBox(height: AppSpacing.xl),
        _buildTextContent(isMobile: true),
        const SizedBox(height: AppSpacing.xl),
        _buildButtons(isMobile: true),
      ],
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextContent(isMobile: false),
              const SizedBox(height: AppSpacing.xxl),
              _buildButtons(isMobile: false),
            ],
          ),
        ),
        const SizedBox(width: AppSpacing.xxxl),
        Expanded(
          flex: 2,
          child: _buildProfileImage(size: 400),
        ),
      ],
    );
  }

  Widget _buildTextContent({required bool isMobile}) {
    return Column(
      crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        // Badge
        AppearAnimation(
          delay: const Duration(milliseconds: 200),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient.scale(0.3),
              borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
              border: Border.all(
                color: AppColors.primary.withOpacity(0.3),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: AppColors.emerald,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.emerald.withOpacity(0.5),
                        blurRadius: 8,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Text(
                  'AVAILABLE FOR WORK',
                  style: AppTypography.overline.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: isMobile ? AppSpacing.lg : AppSpacing.xl),
        
        // Main heading
        AppearAnimation(
          delay: const Duration(milliseconds: 400),
          offset: const Offset(0, 50),
          child: ShaderMask(
            shaderCallback: (bounds) => AppColors.heroGradient.createShader(bounds),
            child: Text(
              'Creative Developer',
              style: (isMobile ? AppTypography.h2 : AppTypography.display1).copyWith(
                color: Colors.white,
              ),
              textAlign: isMobile ? TextAlign.center : TextAlign.start,
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        
        AppearAnimation(
          delay: const Duration(milliseconds: 600),
          offset: const Offset(0, 50),
          child: Text(
            '& UI/UX Designer',
            style: (isMobile ? AppTypography.h3 : AppTypography.h1).copyWith(
              color: AppColors.textPrimary,
            ),
            textAlign: isMobile ? TextAlign.center : TextAlign.start,
          ),
        ),
        SizedBox(height: isMobile ? AppSpacing.lg : AppSpacing.xl),
        
        // Description
        AppearAnimation(
          delay: const Duration(milliseconds: 800),
          offset: const Offset(0, 30),
          child: Text(
            'I craft beautiful digital experiences that combine stunning design with powerful functionality. Let\'s build something amazing together.',
            style: isMobile ? AppTypography.body2 : AppTypography.body1,
            textAlign: isMobile ? TextAlign.center : TextAlign.start,
            maxLines: 3,
          ),
        ),
        
        // Stats
        if (!isMobile) ...[
          const SizedBox(height: AppSpacing.xxl),
          AppearAnimation(
            delay: const Duration(milliseconds: 1000),
            child: Row(
              children: [
                _buildStatItem('1+', 'Years Experience'),
                const SizedBox(width: AppSpacing.xxxl),
                _buildStatItem('10+', 'Projects Completed'),
                const SizedBox(width: AppSpacing.xxxl),
                _buildStatItem('10+', 'Happy Clients'),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildStatItem(String number, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShaderMask(
          shaderCallback: (bounds) => AppColors.primaryGradient.createShader(bounds),
          child: Text(
            number,
            style: AppTypography.h2.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          label,
          style: AppTypography.caption,
        ),
      ],
    );
  }

  Widget _buildButtons({required bool isMobile}) {
    return AppearAnimation(
      delay: const Duration(milliseconds: 1200),
      child: Wrap(
        alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
        spacing: AppSpacing.md,
        runSpacing: AppSpacing.md,
        children: [
          PrimaryButton(
            text: 'View Projects',
            icon: Icons.work_rounded,
            onPressed: () {},
          ),
          PrimaryButton(
            text: 'Contact Me',
            icon: Icons.mail_rounded,
            isOutlined: true,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildProfileImage({required double size}) {
    return AppearAnimation(
      delay: const Duration(milliseconds: 600),
      child: ScaleAppearAnimation(
        delay: const Duration(milliseconds: 800),
        initialScale: 0.8,
        child: HoverTilt(
          maxTilt: 0.02,
          child: Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Animated glow
                AnimatedBuilder(
                  animation: _floatController,
                  builder: (context, child) {
                    return Container(
                      width: size * 1.2,
                      height: size * 1.2,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            AppColors.primary.withOpacity(0.3 * _floatController.value),
                            AppColors.accent.withOpacity(0.2 * _floatController.value),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    );
                  },
                ),
                
                // Profile image with glass effect
                GlowingGlassContainer(
                  width: size,
                  height: size,
                  borderRadius: size / 2,
                  child: ClipOval(
                    child: Image.asset(
                      'assets/profile.jpg',
                      width: size,
                      height: size,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: size,
                          height: size,
                          decoration: BoxDecoration(
                            gradient: AppColors.primaryGradient,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.person_rounded,
                            size: size * 0.5,
                            color: AppColors.textPrimary,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildBackgroundElements() {
    return [
      // Floating circles
      Positioned(
        top: 100,
        left: -50,
        child: _buildFloatingCircle(150, AppColors.primary.withOpacity(0.1)),
      ),
      Positioned(
        bottom: 150,
        right: -80,
        child: _buildFloatingCircle(200, AppColors.accent.withOpacity(0.1)),
      ),
      Positioned(
        top: 300,
        right: 100,
        child: _buildFloatingCircle(80, AppColors.cyan.withOpacity(0.1)),
      ),
    ];
  }

  Widget _buildFloatingCircle(double size, Color color) {
    return AnimatedBuilder(
      animation: _floatController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(
            math.sin(_floatController.value * 2 * math.pi) * 20,
            math.cos(_floatController.value * 2 * math.pi) * 20,
          ),
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
            ),
          ),
        );
      },
    );
  }
}