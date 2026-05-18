import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio_web/data/portfolio_data.dart';
import 'package:portfolio_web/providers/navigation_provider.dart';
import 'package:portfolio_web/providers/theme_provider.dart';
import 'package:portfolio_web/ui/sections/experience_section.dart';
import 'package:portfolio_web/ui/sections/expertise_section.dart';
import 'package:portfolio_web/ui/sections/footer_section.dart';
import 'package:portfolio_web/ui/sections/hero_section.dart';
import 'package:portfolio_web/ui/sections/projects_section.dart';
import 'package:portfolio_web/ui/sections/stats_section.dart';
import 'package:portfolio_web/ui/widgets/mobile_menu_overlay.dart';
import 'package:portfolio_web/ui/widgets/nav_button.dart';
import 'package:portfolio_web/ui/widgets/reveal_animation.dart';
import 'package:portfolio_web/utils/constants.dart';
import 'package:portfolio_web/utils/url_utils.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _menuController;
  bool _isMenuOpen = false;

  @override
  void initState() {
    super.initState();
    _menuController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  void _toggleMenu() {
    setState(() {
      _isMenuOpen = !_isMenuOpen;
      if (_isMenuOpen) {
        _menuController.forward();
      } else {
        _menuController.reverse();
      }
    });
  }

  @override
  void dispose() {
    _menuController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final navProvider = Provider.of<NavigationProvider>(context);
    final isDark = themeProvider.isDarkMode;

    return Stack(
      children: [
        Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          extendBodyBehindAppBar: true,
          appBar: PreferredSize(
            preferredSize: const Size(double.infinity, 100),
            child: CustomAppBar(
              isDark: isDark,
              onThemeToggle: themeProvider.toggleTheme,
              onMenuToggle: _toggleMenu,
              menuController: _menuController,
            ),
          ),
          body: RepaintBoundary(
            child: SingleChildScrollView(
              controller: navProvider.scrollController,
              child: Column(
                children: [
                  HeroSection(
                    onViewProjects: () =>
                        navProvider.scrollTo(navProvider.projectsKey),
                  ),
                  const RevealAnimation(child: StatsSection()),
                  const RevealAnimation(child: ExpertiseSection()),
                  RevealAnimation(
                    child: ProjectsSection(key: navProvider.projectsKey),
                  ),
                  RevealAnimation(
                    child: ExperienceSection(key: navProvider.experienceKey),
                  ),
                  RevealAnimation(
                    child: FooterSection(key: navProvider.contactKey),
                  ),
                ],
              ),
            ),
          ),
        ),

        // --- CUSTOM MOBILE MENU OVERLAY ---
        if (_isMenuOpen || !_menuController.isDismissed)
          Positioned.fill(
            child: MobileMenuOverlay(
              controller: _menuController,
              onClose: _toggleMenu,
              onNav: (key) {
                _toggleMenu();
                navProvider.scrollTo(key);
              },
              projectsKey: navProvider.projectsKey,
              experienceKey: navProvider.experienceKey,
              contactKey: navProvider.contactKey,
            ),
          ),
      ],
    );
  }
}

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    required this.isDark,
    required this.onThemeToggle,
    required this.onMenuToggle,
    required this.menuController,
    super.key,
  });

  final bool isDark;
  final VoidCallback onThemeToggle;
  final VoidCallback onMenuToggle;
  final AnimationController menuController;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final navProvider = Provider.of<NavigationProvider>(context, listen: false);

    return SafeArea(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        alignment: Alignment.topCenter,
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: isDark
                      ? Colors.black.withValues(alpha: 0.3)
                      : Colors.white.withValues(alpha: 0.6),
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(
                    color: isDark
                        ? Colors.white.withValues(alpha: 0.1)
                        : Colors.black.withValues(alpha: 0.05),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 30,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final isMobile =
                        constraints.maxWidth < AppConstants.mobileBreakpoint;
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Semantics(
                          label: 'Portfolio Brand Logo',
                          child: Text(
                            'NT.',
                            style: GoogleFonts.outfit(
                              fontSize: 24,
                              fontWeight: FontWeight.w900,
                              color: theme.colorScheme.onSurface,
                              letterSpacing: -1,
                            ),
                          ),
                        ),
                        if (!isMobile)
                          Row(
                            children: [
                              Semantics(
                                button: true,
                                label: 'Navigate to Work section',
                                child: NavButton(
                                  text: 'Work',
                                  onTap: () => navProvider
                                      .scrollTo(navProvider.projectsKey),
                                ),
                              ),
                              Semantics(
                                button: true,
                                label: 'Navigate to Experience section',
                                child: NavButton(
                                  text: 'Experience',
                                  onTap: () => navProvider
                                      .scrollTo(navProvider.experienceKey),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Semantics(
                                button: true,
                                label: 'Download Resume',
                                child: NavButton(
                                  text: 'Resume',
                                  onTap: () => UrlUtils.launch(
                                    PortfolioData.resumeUrl,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 24),
                              Semantics(
                                button: true,
                                label: isDark
                                    ? 'Switch to Light Mode'
                                    : 'Switch to Dark Mode',
                                child: IconButton(
                                  icon: Icon(
                                    isDark ? Icons.light_mode : Icons.dark_mode,
                                  ),
                                  onPressed: onThemeToggle,
                                  color: theme.colorScheme.onSurface,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Semantics(
                                button: true,
                                label: 'Contact me for hiring',
                                child: ElevatedButton(
                                  onPressed: () => navProvider
                                      .scrollTo(navProvider.contactKey),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: theme.colorScheme.onSurface,
                                    foregroundColor: theme.colorScheme.surface,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 24,
                                      vertical: 12,
                                    ),
                                  ),
                                  child: const Text('Hire Me'),
                                ),
                              ),
                            ],
                          )
                        else
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(
                                  isDark ? Icons.light_mode : Icons.dark_mode,
                                ),
                                onPressed: onThemeToggle,
                                color: theme.colorScheme.onSurface,
                              ),
                              IconButton(
                                icon: AnimatedIcon(
                                  icon: AnimatedIcons.menu_close,
                                  progress: menuController,
                                  color: theme.colorScheme.onSurface,
                                ),
                                onPressed: onMenuToggle,
                              ),
                            ],
                          ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
