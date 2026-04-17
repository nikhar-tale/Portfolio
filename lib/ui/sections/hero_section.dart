import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio_web/theme/app_theme.dart';
import 'package:portfolio_web/data/portfolio_data.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:simple_icons/simple_icons.dart';
import 'dart:math' as math;
import 'dart:ui';

class HeroSection extends StatelessWidget {
  final VoidCallback onViewProjects;
  
  const HeroSection({super.key, required this.onViewProjects});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 800;
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
              _FloatingIcon(icon: SimpleIcons.flutter, color: const Color(0xFF54C5F8), alignment: Alignment(isMobile ? -0.8 : -0.6, isMobile ? -0.8 : -0.7), size: isMobile ? 30 : 60, delay: 0.0, isMobile: isMobile),
              // Firebase (Yellow/Orange)
              _FloatingIcon(icon: SimpleIcons.firebase, color: const Color(0xFFFFCA28), alignment: Alignment(isMobile ? 0.7 : 0.5, isMobile ? -0.9 : -0.6), size: isMobile ? 25 : 50, delay: 1.5, isMobile: isMobile),
              // AWS (Orange)
              _FloatingIcon(icon: FontAwesomeIcons.aws, color: const Color(0xFFFF9900), alignment: Alignment(isMobile ? -0.9 : -0.7, isMobile ? 0.1 : 0.2), size: isMobile ? 20 : 40, delay: 0.8, isMobile: isMobile),
              // Apple (White)
              _FloatingIcon(icon: FontAwesomeIcons.apple, color: Colors.white, alignment: Alignment(isMobile ? 0.8 : 0.6, isMobile ? 0.2 : 0.1), size: isMobile ? 25 : 45, delay: 2.2, isMobile: isMobile),
              // Android (Green)
              _FloatingIcon(icon: FontAwesomeIcons.android, color: const Color(0xFF3DDC84), alignment: Alignment(isMobile ? -0.7 : -0.5, isMobile ? 0.8 : 0.7), size: isMobile ? 35 : 70, delay: 1.2, isMobile: isMobile),
              // Dart (Blue)
              _FloatingIcon(icon: SimpleIcons.dart, color: const Color(0xFF0175C2), alignment: Alignment(isMobile ? 0.9 : 0.7, isMobile ? 0.7 : 0.6), size: isMobile ? 25 : 50, delay: 2.8, isMobile: isMobile),
              // TensorFlow (Orange)
              _FloatingIcon(icon: SimpleIcons.tensorflow, color: const Color(0xFFFF6F00), alignment: Alignment(isMobile ? -0.3 : -0.1, isMobile ? -0.95 : -0.85), size: isMobile ? 20 : 35, delay: 0.5, isMobile: isMobile),
              // Shorebird
              _FloatingIcon(icon: FontAwesomeIcons.dove, color: const Color(0xFFE91E63), alignment: Alignment(isMobile ? 0.4 : 0.2, isMobile ? 0.9 : 0.85), size: isMobile ? 20 : 40, delay: 3.5, isMobile: isMobile),
              
              // --- DARK VIGNETTE TO ENSURE TEXT LEGIBILITY ---
              // This creates a soft, dark blur behind the text, allowing the icons to
              // glow on the edges of the screen but perfectly shielding the text in the center.
              Container(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    colors: [
                      AppTheme.background.withOpacity(0.95), // Solid dark center
                      AppTheme.background.withOpacity(0.6),  // Semi-dark middle
                      AppTheme.background.withOpacity(0.1),  // Almost transparent edges to show aurora
                    ],
                    stops: const [0.2, 0.6, 1.0],
                    radius: isMobile ? 0.9 : 0.7,
                  ),
                ),
              ),
              
              // --- MAIN FOREGROUND CONTENT ---
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 24 : 100,
                  vertical: 100, // Safe padding
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: AppTheme.surface,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: Colors.white.withOpacity(0.1)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.apple, color: Colors.white, size: 16),
                          const SizedBox(width: 8),
                          const Icon(Icons.android, color: AppTheme.secondary, size: 16),
                          const SizedBox(width: 12),
                          Text(
                            "Mobile Engineer",
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    Text(
                      "Hi, I'm Nikhar Tale.",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.outfit(
                        fontSize: isMobile ? 24 : 32,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.secondary,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "Crafting Native\nExperiences.",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.outfit(
                        fontSize: isMobile ? 48 : 96,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        height: 1.0,
                        letterSpacing: -3,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Container(
                      constraints: const BoxConstraints(maxWidth: 600),
                      child: Text(
                        PortfolioData.bio,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          fontSize: isMobile ? 18 : 22,
                          color: AppTheme.textSecondary,
                          height: 1.5,
                        ),
                      ),
                    ),
                    const SizedBox(height: 48),
                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 16,
                      runSpacing: 16,
                      children: [
                        ElevatedButton(
                          onPressed: onViewProjects,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                          child: Text(
                            "View Projects",
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () => launchUrl(Uri.parse('mailto:${PortfolioData.email}')),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.surface,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                          child: Text(
                            "Get in Touch",
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
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
  final IconData icon;
  final Color color;
  final Alignment alignment;
  final double size;
  final double delay;
  final bool isMobile;

  const _FloatingIcon({
    required this.icon,
    required this.color,
    required this.alignment,
    required this.size,
    required this.delay,
    required this.isMobile,
  });

  @override
  State<_FloatingIcon> createState() => _FloatingIconState();
}

class _FloatingIconState extends State<_FloatingIcon> with SingleTickerProviderStateMixin {
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
    return Align(
      alignment: widget.alignment,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final dy = math.sin(_controller.value * math.pi) * 15.0; // Bob up and down by 15 pixels
          return Transform.translate(
            offset: Offset(0, dy),
            child: child,
          );
        },
        child: Container(
          padding: EdgeInsets.all(widget.isMobile ? 16 : 24),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.03),
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white.withOpacity(0.05), width: 1),
            boxShadow: [
              BoxShadow(
                color: widget.color.withOpacity(widget.isMobile ? 0.1 : 0.15),
                blurRadius: widget.isMobile ? 30 : 50,
                spreadRadius: widget.isMobile ? 5 : 10,
              )
            ],
          ),
          child: Icon(
            widget.icon,
            size: widget.size,
            color: widget.color.withOpacity(widget.isMobile ? 0.5 : 0.8), // Slightly more transparent on mobile to ensure text readability
          ),
        ),
      ),
    );
  }
}

class _SocialLink extends StatelessWidget {
  final IconData icon;
  final String text;
  final String url;

  const _SocialLink({
    required this.icon,
    required this.text,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => launchUrl(Uri.parse(url)),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.white.withOpacity(0.1)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: AppTheme.textSecondary, size: 16),
              const SizedBox(width: 8),
              Text(
                text,
                style: GoogleFonts.inter(
                  color: AppTheme.textSecondary,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AnimatedAuroraBackground extends StatefulWidget {
  const _AnimatedAuroraBackground();

  @override
  State<_AnimatedAuroraBackground> createState() => _AnimatedAuroraBackgroundState();
}

class _AnimatedAuroraBackgroundState extends State<_AnimatedAuroraBackground> with SingleTickerProviderStateMixin {
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
    // Flutter Web Performance Optimization:
    // We avoid using BackdropFilter with high sigma values because it causes severe
    // rendering lag on CanvasKit/WebGL. Instead, we use RadialGradients which
    // provide the exact same blurred orb effect but cost 0 extra GPU passes!
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final t = _controller.value * 2 * 3.14159; // 2PI
        return Stack(
          children: [
            // Neon Blue Orb
            Positioned(
              left: MediaQuery.of(context).size.width * 0.2 + 200 * math.cos(t),
              top: 200 + 100 * math.sin(t),
              child: Container(
                width: 600,
                height: 600,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      Colors.blueAccent.withValues(alpha: 0.2),
                      Colors.blueAccent.withValues(alpha: 0.0),
                    ],
                  ),
                ),
              ),
            ),
            // Hot Pink Orb
            Positioned(
              right: MediaQuery.of(context).size.width * 0.2 + 200 * math.cos(t + 2),
              top: 100 + 150 * math.sin(t + 2),
              child: Container(
                width: 700,
                height: 700,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      Colors.pinkAccent.withValues(alpha: 0.2),
                      Colors.pinkAccent.withValues(alpha: 0.0),
                    ],
                  ),
                ),
              ),
            ),
            // Electric Purple Orb
            Positioned(
              left: MediaQuery.of(context).size.width * 0.5 + 150 * math.sin(t + 4),
              bottom: -100 + 100 * math.cos(t + 4),
              child: Container(
                width: 800,
                height: 800,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      Colors.deepPurpleAccent.withValues(alpha: 0.2),
                      Colors.deepPurpleAccent.withValues(alpha: 0.0),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
