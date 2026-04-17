import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio_web/data/portfolio_data.dart';
import 'package:portfolio_web/theme/app_theme.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ExpertiseSection extends StatelessWidget {
  const ExpertiseSection({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 800;
        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 24 : 100,
            vertical: isMobile ? 60 : 100,
          ),
          child: Column(
            children: [
              Text(
                "Technical Arsenal",
                style: GoogleFonts.outfit(
                  fontSize: isMobile ? 36 : 64,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: -2,
                ),
              ),
              SizedBox(height: isMobile ? 40 : 80),
              Wrap(
                spacing: 24,
                runSpacing: 24,
                alignment: WrapAlignment.center,
                children: PortfolioData.expertise.map((item) {
                  return SizedBox(
                    width: isMobile ? double.infinity : 350,
                    child: _ExpertiseCard(item: item, isMobile: isMobile),
                  );
                }).toList(),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ExpertiseCard extends StatefulWidget {
  final Map<String, dynamic> item;
  final bool isMobile;
  const _ExpertiseCard({required this.item, required this.isMobile});

  @override
  State<_ExpertiseCard> createState() => _ExpertiseCardState();
}

class _ExpertiseCardState extends State<_ExpertiseCard> {
  bool _isHovered = false;
  bool get _active => _isHovered || widget.isMobile;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isHovered = true),
      onTapUp: (_) => setState(() => _isHovered = false),
      onTapCancel: () => setState(() => _isHovered = false),
      child: MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: EdgeInsets.all(widget.isMobile ? 24 : 40),
        decoration: BoxDecoration(
          color: _active ? Colors.white.withValues(alpha: 0.05) : Colors.white.withValues(alpha: 0.02),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: _active ? AppTheme.secondary.withValues(alpha: 0.5) : Colors.white.withValues(alpha: 0.05),
          ),
          boxShadow: _active ? [
            BoxShadow(
              color: AppTheme.secondary.withValues(alpha: 0.1),
              blurRadius: 30,
              offset: const Offset(0, 10),
            )
          ] : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.secondary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                widget.item['icon'] as IconData,
                color: AppTheme.secondary,
                size: widget.isMobile ? 24 : 32,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              widget.item['title'],
              style: GoogleFonts.outfit(
                fontSize: widget.isMobile ? 20 : 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              widget.item['description'],
              style: GoogleFonts.inter(
                fontSize: widget.isMobile ? 14 : 16,
                height: 1.6,
                color: AppTheme.textSecondary,
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
