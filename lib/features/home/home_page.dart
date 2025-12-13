import 'package:flutter/material.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/spacing.dart';
import '../../shared/layout/responsive_layout.dart';
import 'home_view.dart';
import '../skills/skills_page.dart';
import '../projects/projects_page.dart';
import '../contacts/contacts_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _homeKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _contactsKey = GlobalKey();

  int _selectedIndex = 0;
  bool _showAppBar = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    // Показать AppBar при прокрутке
    if (_scrollController.offset > 100 && !_showAppBar) {
      setState(() => _showAppBar = true);
    } else if (_scrollController.offset <= 100 && _showAppBar) {
      setState(() => _showAppBar = false);
    }

    // Определить текущую секцию
    _updateSelectedIndex();
  }

  void _updateSelectedIndex() {
    final scrollPosition = _scrollController.offset;
    final viewportHeight = MediaQuery.of(context).size.height;

    if (_isInView(_contactsKey, scrollPosition, viewportHeight)) {
      if (_selectedIndex != 3) setState(() => _selectedIndex = 3);
    } else if (_isInView(_projectsKey, scrollPosition, viewportHeight)) {
      if (_selectedIndex != 2) setState(() => _selectedIndex = 2);
    } else if (_isInView(_skillsKey, scrollPosition, viewportHeight)) {
      if (_selectedIndex != 1) setState(() => _selectedIndex = 1);
    } else if (_selectedIndex != 0) {
      setState(() => _selectedIndex = 0);
    }
  }

  bool _isInView(GlobalKey key, double scrollPosition, double viewportHeight) {
    final context = key.currentContext;
    if (context == null) return false;

    final box = context.findRenderObject() as RenderBox?;
    if (box == null) return false;

    final position = box.localToGlobal(Offset.zero);
    final sectionTop = position.dy + scrollPosition;
    final sectionBottom = sectionTop + box.size.height;

    return scrollPosition + viewportHeight / 2 >= sectionTop &&
        scrollPosition + viewportHeight / 2 <= sectionBottom;
  }

  void _scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context == null) return;

    Scrollable.ensureVisible(
      context,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveLayout.isMobile(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: isMobile
          ? _buildMobileAppBar()
          : _buildDesktopAppBar(),
      drawer: isMobile ? _buildMobileDrawer() : null,
      body: Stack(
        children: [
          // Основной контент
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    HomeView(key: _homeKey),
                    SkillsPage(key: _skillsKey),
                    ProjectsPage(key: _projectsKey),
                    ContactsPage(key: _contactsKey),
                  ],
                ),
              ),
            ],
          ),
          // Floating navigation для десктопа
          if (!isMobile) _buildFloatingNav(),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildMobileAppBar() {
    return AppBar(
      backgroundColor: _showAppBar
          ? AppColors.surface.withOpacity(0.9)
          : Colors.transparent,
      elevation: 0,
      leading: Builder(
        builder: (context) => IconButton(
          icon: const Icon(Icons.menu_rounded),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
      title: AnimatedOpacity(
        opacity: _showAppBar ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 300),
        child: const Text('Portfolio'),
      ),
    );
  }

  PreferredSizeWidget _buildDesktopAppBar() {
    return AppBar(
      backgroundColor: _showAppBar
          ? AppColors.surface.withOpacity(0.9)
          : Colors.transparent,
      elevation: 0,
      toolbarHeight: AppSpacing.appBarHeight,
      title: AnimatedOpacity(
        opacity: _showAppBar ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 300),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          child: Row(
            children: [
              const Text('Portfolio'),
              const Spacer(),
              _buildNavButton('Home', 0, _homeKey),
              _buildNavButton('Skills', 1, _skillsKey),
              _buildNavButton('Projects', 2, _projectsKey),
              _buildNavButton('Contact', 3, _contactsKey),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavButton(String label, int index, GlobalKey key) {
    final isSelected = _selectedIndex == index;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
      child: TextButton(
        onPressed: () => _scrollToSection(key),
        style: TextButton.styleFrom(
          foregroundColor: isSelected ? AppColors.primary : AppColors.textSecondary,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(label),
            const SizedBox(height: 4),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: 2,
              width: isSelected ? 20 : 0,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFloatingNav() {
    return Positioned(
      right: AppSpacing.xl,
      top: 0,
      bottom: 0,
      child: Center(
        child: AnimatedOpacity(
          opacity: _showAppBar ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 300),
          child: Container(
            padding: const EdgeInsets.all(AppSpacing.sm),
            decoration: BoxDecoration(
              color: AppColors.surface.withOpacity(0.8),
              borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
              border: Border.all(
                color: AppColors.textTertiary.withOpacity(0.1),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildFloatingNavItem(Icons.home_rounded, 0, _homeKey),
                const SizedBox(height: AppSpacing.sm),
                _buildFloatingNavItem(Icons.code_rounded, 1, _skillsKey),
                const SizedBox(height: AppSpacing.sm),
                _buildFloatingNavItem(Icons.work_rounded, 2, _projectsKey),
                const SizedBox(height: AppSpacing.sm),
                _buildFloatingNavItem(Icons.mail_rounded, 3, _contactsKey),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFloatingNavItem(IconData icon, int index, GlobalKey key) {
    final isSelected = _selectedIndex == index;

    return InkWell(
      onTap: () => _scrollToSection(key),
      borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.sm),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withOpacity(0.2)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
        ),
        child: Icon(
          icon,
          color: isSelected ? AppColors.primary : AppColors.textSecondary,
          size: 24,
        ),
      ),
    );
  }

  Widget _buildMobileDrawer() {
    return Drawer(
      backgroundColor: AppColors.surface,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Portfolio',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: AppSpacing.xxl),
              _buildDrawerItem(Icons.home_rounded, 'Home', 0, _homeKey),
              _buildDrawerItem(Icons.code_rounded, 'Skills', 1, _skillsKey),
              _buildDrawerItem(Icons.work_rounded, 'Projects', 2, _projectsKey),
              _buildDrawerItem(Icons.mail_rounded, 'Contact', 3, _contactsKey),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String label, int index, GlobalKey key) {
    final isSelected = _selectedIndex == index;

    return ListTile(
      leading: Icon(
        icon,
        color: isSelected ? AppColors.primary : AppColors.textSecondary,
      ),
      title: Text(
        label,
        style: TextStyle(
          color: isSelected ? AppColors.primary : AppColors.textPrimary,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
      selected: isSelected,
      selectedTileColor: AppColors.primary.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      ),
      onTap: () {
        Navigator.pop(context);
        _scrollToSection(key);
      },
    );
  }
}