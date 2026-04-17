import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio_web/data/portfolio_data.dart';
import 'package:portfolio_web/theme/app_theme.dart';
import 'package:responsive_builder/responsive_builder.dart';

class StatsSection extends StatelessWidget {
  const StatsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 800;
        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: isMobile ? 40 : 60),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.02),
            border: Border.symmetric(
              horizontal: BorderSide(color: Colors.white.withValues(alpha: 0.05)),
            ),
          ),
          child: Wrap(
            alignment: WrapAlignment.spaceEvenly,
            spacing: isMobile ? 20 : 40,
            runSpacing: isMobile ? 32 : 40,
            children: PortfolioData.stats.map((stat) {
              return SizedBox(
                width: isMobile ? (MediaQuery.of(context).size.width / 2) - 30 : null,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      stat['value']!,
                      style: GoogleFonts.outfit(
                        fontSize: isMobile ? 32 : 56,
                        fontWeight: FontWeight.w900,
                        color: AppTheme.secondary,
                        letterSpacing: -1,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      stat['label']!.toUpperCase(),
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        fontSize: isMobile ? 10 : 12,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.textSecondary,
                        letterSpacing: 2,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
