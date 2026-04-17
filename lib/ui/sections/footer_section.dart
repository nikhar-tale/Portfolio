import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio_web/theme/app_theme.dart';
import 'package:portfolio_web/data/portfolio_data.dart';
import 'package:url_launcher/url_launcher.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
      color: Colors.black, // Dark footer
      child: Column(
        children: [
          Text(
            "Built with Flutter Web · ${DateTime.now().year}",
            style: GoogleFonts.inter(
              color: AppTheme.textSecondary,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.email, color: AppTheme.textSecondary),
                  tooltip: "Email",
                  onPressed: () => launchUrl(Uri.parse('mailto:${PortfolioData.email}')),
                ),
                IconButton(
                  icon: const Icon(Icons.phone, color: AppTheme.textSecondary),
                  tooltip: "Phone",
                  onPressed: () => launchUrl(Uri.parse('tel:${PortfolioData.phone}')),
                ),
                IconButton(
                  icon: const Icon(Icons.code, color: AppTheme.textSecondary),
                  tooltip: "GitHub",
                  onPressed: () => launchUrl(Uri.parse(PortfolioData.github)),
                ),
                IconButton(
                  icon: const Icon(Icons.work, color: AppTheme.textSecondary),
                  tooltip: "LinkedIn",
                  onPressed: () => launchUrl(Uri.parse(PortfolioData.linkedin)),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
