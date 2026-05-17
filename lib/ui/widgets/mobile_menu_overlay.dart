import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:portfolio_web/data/portfolio_data.dart';
import 'package:portfolio_web/theme/app_theme.dart';

class MobileMenuOverlay extends StatelessWidget {
  final AnimationController controller;
  final VoidCallback onClose;
  final Function(GlobalKey) onNav;
  final GlobalKey projectsKey;
  final GlobalKey experienceKey;
  final GlobalKey contactKey;

  const MobileMenuOverlay({
    super.key,
    required this.controller,
    required this.onClose,
    required this.onNav,
    required this.projectsKey,
    required this.experienceKey,
    required this.contactKey,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 15 * controller.value,
            sigmaY: 15 * controller.value,
          ),
          child: Container(
            color: (isDark ? Colors.black : Colors.white).withValues(alpha: 0.8 * controller.value),
            child: SafeArea(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _MenuEntry(
                      text: "WORK",
                      index: 0,
                      controller: controller,
                      onTap: () => onNav(projectsKey),
                    ),
                    _MenuEntry(
                      text: "EXPERIENCE",
                      index: 1,
                      controller: controller,
                      onTap: () => onNav(experienceKey),
                    ),
                    _MenuEntry(
                      text: "RESUME",
                      index: 2,
                      controller: controller,
                      onTap: () => launchUrl(
                        Uri.parse(PortfolioData.resumeUrl),
                        mode: LaunchMode.externalApplication,
                      ),
                    ),
                    _MenuEntry(
                      text: "HIRE ME",
                      index: 3,
                      controller: controller,
                      onTap: () => onNav(contactKey),
                      isHighlight: true,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _MenuEntry extends StatelessWidget {
  final String text;
  final int index;
  final AnimationController controller;
  final VoidCallback onTap;
  final bool isHighlight;

  const _MenuEntry({
    required this.text,
    required this.index,
    required this.controller,
    required this.onTap,
    this.isHighlight = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final start = 0.2 + (index * 0.1);
        final end = (start + 0.4).clamp(0.0, 1.0);
        
        final anim = CurvedAnimation(
          parent: controller,
          curve: Interval(start, end, curve: Curves.easeOutBack),
        );

        return Opacity(
          opacity: anim.value,
          child: Transform.translate(
            offset: Offset(0, 50 * (1 - anim.value)),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: GestureDetector(
                onTap: onTap,
                child: Text(
                  text,
                  style: theme.textTheme.displaySmall?.copyWith(
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                    color: isHighlight ? AppTheme.secondary : theme.colorScheme.onSurface,
                    letterSpacing: -1,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
