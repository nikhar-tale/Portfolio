import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio_web/data/portfolio_data.dart';
import 'package:portfolio_web/ui/sections/hero_section.dart';
import 'package:portfolio_web/ui/sections/stats_section.dart';
import 'package:portfolio_web/ui/sections/expertise_section.dart';
import 'package:portfolio_web/ui/sections/projects_section.dart';
import 'package:portfolio_web/ui/sections/experience_section.dart';
import 'package:portfolio_web/ui/sections/footer_section.dart';
import 'package:portfolio_web/ui/widgets/nav_button.dart';
import 'package:portfolio_web/ui/widgets/mobile_menu_overlay.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  final VoidCallback onThemeToggle;
  final ThemeMode currentThemeMode;

  const HomePage({
    super.key,
    required this.onThemeToggle,
    required this.currentThemeMode,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _experienceKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

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

  void _scrollTo(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      final renderBox = context.findRenderObject() as RenderBox;
      final position = renderBox.localToGlobal(Offset.zero);
      final target = _scrollController.offset + position.dy - 120;

      _scrollController.animateTo(
        target.clamp(0.0, _scrollController.position.maxScrollExtent),
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _menuController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = widget.currentThemeMode == ThemeMode.dark;
    final theme = Theme.of(context);

    return Stack(
      children: [
        Scaffold(
          backgroundColor: theme.scaffoldBackgroundColor,
          extendBodyBehindAppBar: true,
          appBar: PreferredSize(
            preferredSize: const Size(double.infinity, 100),
            child: SafeArea(
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
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                        decoration: BoxDecoration(
                          color: isDark ? Colors.black.withValues(alpha: 0.3) : Colors.white.withValues(alpha: 0.6),
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(color: isDark ? Colors.white.withValues(alpha: 0.1) : Colors.black.withValues(alpha: 0.05)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              blurRadius: 30,
                              offset: const Offset(0, 10),
                            )
                          ]
                        ),
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            final isMobile = constraints.maxWidth < 900;
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Semantics(
                                  label: "Portfolio Brand Logo",
                                  child: Text(
                                    "NT.",
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
                                        label: "Navigate to Work section",
                                        child: NavButton(text: "Work", onTap: () => _scrollTo(_projectsKey)),
                                      ),
                                      Semantics(
                                        button: true,
                                        label: "Navigate to Experience section",
                                        child: NavButton(text: "Experience", onTap: () => _scrollTo(_experienceKey)),
                                      ),
                                      const SizedBox(width: 8),
                                      Semantics(
                                        button: true,
                                        label: "Download Resume",
                                        child: NavButton(
                                          text: "Resume", 
                                          onTap: () => launchUrl(
                                            Uri.parse(PortfolioData.resumeUrl),
                                            mode: LaunchMode.externalApplication,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 24),
                                      Semantics(
                                        button: true,
                                        label: isDark ? "Switch to Light Mode" : "Switch to Dark Mode",
                                        child: IconButton(
                                          icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
                                          onPressed: widget.onThemeToggle,
                                          color: theme.colorScheme.onSurface,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Semantics(
                                        button: true,
                                        label: "Contact me for hiring",
                                        child: ElevatedButton(
                                          onPressed: () => _scrollTo(_contactKey),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: theme.colorScheme.onSurface,
                                            foregroundColor: theme.colorScheme.surface,
                                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                          ),
                                          child: const Text("Hire Me"),
                                        ),
                                      ),
                                    ],
                                  )
                                else
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
                                        onPressed: widget.onThemeToggle,
                                        color: theme.colorScheme.onSurface,
                                      ),
                                      IconButton(
                                        icon: AnimatedIcon(
                                          icon: AnimatedIcons.menu_close,
                                          progress: _menuController,
                                          color: theme.colorScheme.onSurface,
                                        ),
                                        onPressed: _toggleMenu,
                                      ),
                                    ],
                                  )
                              ],
                            );
                          }
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          body: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                HeroSection(
                  onViewProjects: () => _scrollTo(_projectsKey),
                ),
                const StatsSection(),
                const ExpertiseSection(),
                ProjectsSection(key: _projectsKey),
                ExperienceSection(key: _experienceKey),
                FooterSection(key: _contactKey),
              ],
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
                _scrollTo(key);
              },
              projectsKey: _projectsKey,
              experienceKey: _experienceKey,
              contactKey: _contactKey,
            ),
          ),
      ],
    );
  }
}
