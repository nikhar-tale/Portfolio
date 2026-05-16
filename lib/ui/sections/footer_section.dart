import 'package:flutter/material.dart';
import 'package:portfolio_web/theme/app_theme.dart';
import 'package:portfolio_web/data/portfolio_data.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 800;
        final theme = Theme.of(context);
        final isDark = theme.brightness == Brightness.dark;

        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            vertical: isMobile ? 60 : 100,
            horizontal: 24,
          ),
          decoration: BoxDecoration(
            color: isDark ? Colors.black : theme.colorScheme.surface,
            border: Border(
              top: BorderSide(color: isDark ? Colors.white.withValues(alpha: 0.05) : Colors.black.withValues(alpha: 0.05), width: 1),
            ),
          ),
          child: Column(
            children: [
              Semantics(
                label: "Footer call to action",
                child: Text(
                  "Let's build something\namazing together.",
                  textAlign: TextAlign.center,
                  style: theme.textTheme.displaySmall?.copyWith(
                    fontSize: isMobile ? 32 : 48,
                    height: 1.1,
                  ),
                ),
              ),
              SizedBox(height: isMobile ? 32 : 48),
              Semantics(
                button: true,
                label: "Send an email to contact me",
                child: ElevatedButton.icon(
                  onPressed: () => launchUrl(Uri.parse('mailto:${PortfolioData.email}')),
                  icon: const Icon(Icons.email),
                  label: Text(
                    "Get in Touch",
                    style: theme.textTheme.labelLarge?.copyWith(fontSize: isMobile ? 16 : 18),
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
                    shadowColor: AppTheme.secondary.withValues(alpha: 0.5),
                  ),
                ),
              ),
              SizedBox(height: isMobile ? 48 : 64),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 24,
                runSpacing: 24,
                children: [
                  Semantics(
                    button: true,
                    label: "Visit my GitHub profile",
                    child: _SocialIcon(icon: FontAwesomeIcons.github, url: PortfolioData.github),
                  ),
                  Semantics(
                    button: true,
                    label: "Visit my LinkedIn profile",
                    child: _SocialIcon(icon: FontAwesomeIcons.linkedin, url: PortfolioData.linkedin),
                  ),
                  Semantics(
                    button: true,
                    label: "Call me via phone",
                    child: _SocialIcon(icon: Icons.phone, url: 'tel:${PortfolioData.phone}'),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Text(
                "© ${DateTime.now().year} Nikhar Tale. Built with Flutter.",
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(fontSize: 14),
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
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () => launchUrl(Uri.parse(widget.url)),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _isHovered ? (isDark ? Colors.white.withValues(alpha: 0.05) : Colors.black.withValues(alpha: 0.05)) : Colors.transparent,
            shape: BoxShape.circle,
            border: Border.all(
              color: _isHovered ? (isDark ? Colors.white.withValues(alpha: 0.2) : Colors.black.withValues(alpha: 0.1)) : Colors.transparent,
            )
          ),
          child: Icon(
            widget.icon,
            color: _isHovered ? theme.textTheme.displayLarge?.color : theme.textTheme.bodyMedium?.color,
            size: 24,
          ),
        ),
      ),
    );
  }
}
