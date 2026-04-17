import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio_web/theme/app_theme.dart';
import 'package:portfolio_web/data/portfolio_data.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 800;
        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            vertical: isMobile ? 60 : 100,
            horizontal: 24,
          ),
          decoration: BoxDecoration(
            color: Colors.black,
            border: Border(
              top: BorderSide(color: Colors.white.withOpacity(0.05), width: 1),
            ),
          ),
          child: Column(
            children: [
              Text(
                "Let's build something\namazing together.",
                textAlign: TextAlign.center,
                style: GoogleFonts.outfit(
                  fontSize: isMobile ? 32 : 48,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: -2,
                  height: 1.1,
                ),
              ),
              SizedBox(height: isMobile ? 32 : 48),
              ElevatedButton.icon(
                onPressed: () => launchUrl(Uri.parse('mailto:${PortfolioData.email}')),
                icon: const Icon(Icons.email),
                label: Text(
                  "Get in Touch",
                  style: GoogleFonts.inter(fontSize: isMobile ? 16 : 18, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.secondary,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 32 : 40,
                    vertical: isMobile ? 20 : 24,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  elevation: 20,
                  shadowColor: AppTheme.secondary.withOpacity(0.5),
                ),
              ),
              SizedBox(height: isMobile ? 48 : 64),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 24,
                runSpacing: 24,
                children: [
                  _SocialIcon(icon: FontAwesomeIcons.github, url: PortfolioData.github),
                  _SocialIcon(icon: FontAwesomeIcons.linkedin, url: PortfolioData.linkedin),
                  _SocialIcon(icon: Icons.phone, url: 'tel:${PortfolioData.phone}'),
                ],
              ),
              const SizedBox(height: 32),
              Text(
                "© ${DateTime.now().year} Nikhar Tale. Built with Flutter.",
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  color: AppTheme.textSecondary,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _SocialIcon extends StatefulWidget {
  final IconData icon;
  final String url;

  const _SocialIcon({required this.icon, required this.url});

  @override
  State<_SocialIcon> createState() => _SocialIconState();
}

class _SocialIconState extends State<_SocialIcon> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () => launchUrl(Uri.parse(widget.url)),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _isHovered ? AppTheme.surface : Colors.transparent,
            shape: BoxShape.circle,
            border: Border.all(
              color: _isHovered ? Colors.white.withOpacity(0.2) : Colors.transparent,
            )
          ),
          child: Icon(
            widget.icon,
            color: _isHovered ? Colors.white : AppTheme.textSecondary,
            size: 24,
          ),
        ),
      ),
    );
  }
}
