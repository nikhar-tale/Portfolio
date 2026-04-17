import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio_web/theme/app_theme.dart';
import 'package:portfolio_web/ui/sections/hero_section.dart';
import 'package:portfolio_web/ui/sections/projects_section.dart';
import 'package:portfolio_web/ui/sections/experience_section.dart';
import 'package:portfolio_web/ui/sections/footer_section.dart';
import 'package:responsive_builder/responsive_builder.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _experienceKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  void _scrollTo(GlobalKey key) {
    if (key.currentContext != null) {
      Scrollable.ensureVisible(
        key.currentContext!,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 80),
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              color: Colors.black.withOpacity(0.5),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: ResponsiveBuilder(
                builder: (context, sizingInformation) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "NT.",
                        style: GoogleFonts.inter(
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          letterSpacing: -1,
                        ),
                      ),
                      if (!sizingInformation.isMobile)
                        Row(
                          children: [
                            _NavButton(text: "Work", onTap: () => _scrollTo(_projectsKey)),
                            _NavButton(text: "Experience", onTap: () => _scrollTo(_experienceKey)),
                            _NavButton(text: "Contact", onTap: () => _scrollTo(_contactKey)),
                          ],
                        )
                      else
                        IconButton(
                          icon: const Icon(Icons.menu, color: Colors.white),
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              backgroundColor: AppTheme.surface,
                              builder: (context) => SafeArea(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ListTile(
                                      title: Text("Work", style: TextStyle(color: Colors.white)),
                                      onTap: () {
                                        Navigator.pop(context);
                                        _scrollTo(_projectsKey);
                                      },
                                    ),
                                    ListTile(
                                      title: Text("Experience", style: TextStyle(color: Colors.white)),
                                      onTap: () {
                                        Navigator.pop(context);
                                        _scrollTo(_experienceKey);
                                      },
                                    ),
                                    ListTile(
                                      title: Text("Contact", style: TextStyle(color: Colors.white)),
                                      onTap: () {
                                        Navigator.pop(context);
                                        _scrollTo(_contactKey);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        )
                    ],
                  );
                }
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
            ProjectsSection(key: _projectsKey),
            ExperienceSection(key: _experienceKey),
            FooterSection(key: _contactKey),
          ],
        ),
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const _NavButton({required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 32),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: onTap,
          child: Text(
            text,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppTheme.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}
