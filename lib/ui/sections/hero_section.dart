import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio_web/data/portfolio_data.dart';
import 'package:portfolio_web/theme/app_theme.dart';
import 'package:portfolio_web/utils/constants.dart';
import 'package:portfolio_web/utils/url_utils.dart';
import 'package:simple_icons/simple_icons.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({required this.onViewProjects, super.key});
  final VoidCallback onViewProjects;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < AppConstants.mobileBreakpoint;
        final screenHeight = MediaQuery.of(context).size.height;

        return Container(
          constraints: BoxConstraints(minHeight: screenHeight),
          width: double.infinity,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // --- CRAZY ANIMATED AURORA BACKGROUND ---
              const Positioned.fill(
                child: _AnimatedAuroraBackground(),
              ),

              // Background floating brand icons
              // Flutter (Light Blue)
              _FloatingIcon(
                icon: SimpleIcons.flutter,
                color: const Color(0xFF54C5F8),
                alignment: Alignment(
                  isMobile ? -0.8 : -0.6,
                  isMobile ? -0.8 : -0.7,
                ),
                size: isMobile ? 30 : 60,
                delay: 0,
                isMobile: isMobile,
              ),
              // Firebase (Yellow/Orange)
              _FloatingIcon(
                icon: SimpleIcons.firebase,
                color: const Color(0xFFFFCA28),
                alignment:
                    Alignment(isMobile ? 0.7 : 0.5, isMobile ? -0.9 : -0.6),
                size: isMobile ? 25 : 50,
                delay: 1.5,
                isMobile: isMobile,
              ),
              // AWS (Orange)
              _FloatingIcon(
                icon: FontAwesomeIcons.aws,
                color: const Color(0xFFFF9900),
                alignment:
                    Alignment(isMobile ? -0.9 : -0.7, isMobile ? 0.1 : 0.2),
                size: isMobile ? 20 : 40,
                delay: 0.8,
                isMobile: isMobile,
              ),
              // Apple (White)
              _FloatingIcon(
                icon: FontAwesomeIcons.apple,
                color: Colors.white,
                alignment:
                    Alignment(isMobile ? 0.8 : 0.6, isMobile ? 0.2 : 0.1),
                size: isMobile ? 25 : 45,
                delay: 2.2,
                isMobile: isMobile,
              ),
              // Android (Green)
              _FloatingIcon(
                icon: FontAwesomeIcons.android,
                color: const Color(0xFF3DDC84),
                alignment:
                    Alignment(isMobile ? -0.7 : -0.5, isMobile ? 0.8 : 0.7),
                size: isMobile ? 35 : 70,
                delay: 1.2,
                isMobile: isMobile,
              ),
              // Dart (Blue)
              _FloatingIcon(
                icon: SimpleIcons.dart,
                color: const Color(0xFF0175C2),
                alignment:
                    Alignment(isMobile ? 0.9 : 0.7, isMobile ? 0.7 : 0.6),
                size: isMobile ? 25 : 50,
                delay: 2.8,
                isMobile: isMobile,
              ),
              // TensorFlow (Orange)
              _FloatingIcon(
                icon: SimpleIcons.tensorflow,
                color: const Color(0xFFFF6F00),
                alignment:
                    Alignment(isMobile ? -0.3 : -0.1, isMobile ? -0.95 : -0.85),
                size: isMobile ? 20 : 35,
                delay: 0.5,
                isMobile: isMobile,
              ),
              // Shorebird
              _FloatingIcon(
                icon: FontAwesomeIcons.dove,
                color: const Color(0xFFE91E63),
                alignment:
                    Alignment(isMobile ? 0.4 : 0.2, isMobile ? 0.9 : 0.85),
                size: isMobile ? 20 : 40,
                delay: 3.5,
                isMobile: isMobile,
              ),

              // --- DARK VIGNETTE TO ENSURE TEXT LEGIBILITY ---
              Container(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    colors: [
                      AppTheme.background
                          .withValues(alpha: 0.95), // Solid dark center
                      AppTheme.background
                          .withValues(alpha: 0.6), // Semi-dark middle
                      AppTheme.background
                          .withValues(alpha: 0.1), // Almost transparent edges
                    ],
                    stops: const [0.2, 0.6, 1],
                    radius: isMobile ? 0.9 : 0.7,
                  ),
                ),
              ),

              // --- MAIN FOREGROUND CONTENT ---
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? AppConstants.mobilePadding : AppConstants.desktopPadding,
                  vertical: 100, // Safe padding
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: AppTheme.surface,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.1),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.5),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.apple, color: Colors.white, size: 16),
                          SizedBox(width: 8),
                          Icon(
                            Icons.android,
                            color: AppTheme.secondary,
                            size: 16,
                          ),
                          SizedBox(width: 12),
                          Text(
                            'Mobile Engineer',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    Semantics(
                      label: 'Hero section title',
                      child: Text(
                        "Hi, I'm Nikhar Tale.",
                        textAlign: TextAlign.center,
                        style:
                            Theme.of(context).textTheme.headlineLarge?.copyWith(
                                  color: AppTheme.secondary,
                                  fontSize: isMobile ? 24 : 32,
                                ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Semantics(
                      label: 'Primary skill proposition',
                      child: Text(
                        'Crafting Native\nExperiences.',
                        textAlign: TextAlign.center,
                        style:
                            Theme.of(context).textTheme.displayLarge?.copyWith(
                                  fontSize: isMobile ? 48 : 96,
                                ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Semantics(
                      label: 'Short biography',
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 600),
                        child: Text(
                          PortfolioData.bio,
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    fontSize: isMobile ? 18 : 22,
                                    color: AppTheme.textSecondary,
                                  ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 48),
                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 16,
                      runSpacing: 16,
                      children: [
                        Semantics(
                          button: true,
                          label: 'Navigate to Projects section',
                          child: ElevatedButton(
                            onPressed: onViewProjects,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 32,
                                vertical: 20,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                            child: Text(
                              'View Projects',
                              style: GoogleFonts.inter(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Semantics(
                          button: true,
                          label: 'Download my professional resume',
                          child: ElevatedButton(
                            onPressed: () =>
                                UrlUtils.launch(PortfolioData.resumeUrl),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Colors.white.withValues(alpha: 0.05),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 32,
                                vertical: 20,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                                side: BorderSide(
                                  color: Colors.white.withValues(alpha: 0.1),
                                ),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.description_outlined,
                                    size: 20),
                                const SizedBox(width: 8),
                                Text(
                                  'Resume',
                                  style: GoogleFonts.inter(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Semantics(
                          button: true,
                          label: 'Send me an email to get in touch',
                          child: ElevatedButton(
                            onPressed: () =>
                                UrlUtils.launchMail(PortfolioData.email),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.surface,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 32,
                                vertical: 20,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                            child: Text(
                              'Get in Touch',
                              style: GoogleFonts.inter(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _FloatingIcon extends StatefulWidget {
  const _FloatingIcon({
    required this.icon,
    required this.color,
    required this.alignment,
    required this.size,
    required this.delay,
    required this.isMobile,
  });
  final IconData icon;
  final Color color;
  final Alignment alignment;
  final double size;
  final double delay;
  final bool isMobile;

  @override
  State<_FloatingIcon> createState() => _FloatingIconState();
}

class _FloatingIconState extends State<_FloatingIcon>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );

    // Stagger the animations
    Future.delayed(Duration(milliseconds: (widget.delay * 1000).toInt()), () {
      if (mounted) {
        _controller.repeat(reverse: true);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final bubbleColor = isDark ? Colors.white : theme.colorScheme.onSurface;

    return Align(
      alignment: widget.alignment,
      child: RepaintBoundary(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            final dy = math.sin(_controller.value * math.pi) *
                15.0; // Bob up and down by 15 pixels
            return Transform.translate(
              offset: Offset(0, dy),
              child: child,
            );
          },
          child: Container(
            padding: EdgeInsets.all(widget.isMobile ? 16 : 24),
            decoration: BoxDecoration(
              color: bubbleColor.withValues(alpha: isDark ? 0.03 : 0.05),
              shape: BoxShape.circle,
              border: Border.all(
                color: bubbleColor.withValues(alpha: isDark ? 0.05 : 0.1),
              ),
              boxShadow: [
                BoxShadow(
                  color: widget.color
                      .withValues(alpha: widget.isMobile ? 0.1 : 0.15),
                  blurRadius: widget.isMobile ? 30 : 50,
                  spreadRadius: widget.isMobile ? 5 : 10,
                ),
              ],
            ),
            child: Icon(
              widget.icon,
              size: widget.size,
              color: widget.color.withValues(
                alpha: widget.isMobile ? 0.5 : 0.8,
              ), // Slightly more transparent on mobile
            ),
          ),
        ),
      ),
    );
  }
}

class _AnimatedAuroraBackground extends StatefulWidget {
  const _AnimatedAuroraBackground();

  @override
  State<_AnimatedAuroraBackground> createState() =>
      _AnimatedAuroraBackgroundState();
}

class _AnimatedAuroraBackgroundState extends State<_AnimatedAuroraBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 15),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return RepaintBoundary(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final t = _controller.value * 2 * 3.14159; // 2PI
          return Stack(
            children: [
              // Neon Blue Orb
              Positioned(
                left: size.width * 0.2 + 200 * math.cos(t),
                top: 200 + 100 * math.sin(t),
                child: const _AuroraOrb(
                  size: 600,
                  color: Color.fromARGB(51, 68, 138, 255),
                ),
              ),
              // Hot Pink Orb
              Positioned(
                right: size.width * 0.2 + 200 * math.cos(t + 2),
                top: 100 + 150 * math.sin(t + 2),
                child: const _AuroraOrb(
                  size: 700,
                  color: Color.fromARGB(51, 255, 64, 129),
                ),
              ),
              // Electric Purple Orb
              Positioned(
                left: size.width * 0.5 + 150 * math.sin(t + 4),
                bottom: -100 + 100 * math.cos(t + 4),
                child: const _AuroraOrb(
                  size: 800,
                  color: Color.fromARGB(51, 124, 77, 255),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _AuroraOrb extends StatelessWidget {
  const _AuroraOrb({required this.size, required this.color});
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            color,
            color.withValues(alpha: 0),
          ],
        ),
      ),
    );
  }
}
