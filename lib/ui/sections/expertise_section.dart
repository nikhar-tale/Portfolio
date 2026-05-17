import 'package:flutter/material.dart';
import 'package:portfolio_web/data/portfolio_data.dart';
import 'package:portfolio_web/models/expertise.dart';
import 'package:portfolio_web/theme/app_theme.dart';

class ExpertiseSection extends StatelessWidget {
  const ExpertiseSection({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 800;
        final theme = Theme.of(context);

        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 24 : 100,
            vertical: 100,
          ),
          width: double.infinity,
          child: Column(
            children: [
              Semantics(
                header: true,
                child: Text(
                  'Expertise',
                  style: theme.textTheme.displaySmall?.copyWith(
                    fontSize: isMobile ? 40 : 64,
                  ),
                ),
              ),
              const SizedBox(height: 80),
              Wrap(
                spacing: 40,
                runSpacing: 40,
                alignment: WrapAlignment.center,
                children: PortfolioData.expertise.map((exp) {
                  return _ExpertiseCard(expertise: exp);
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
  const _ExpertiseCard({required this.expertise});
  final Expertise expertise;

  @override
  State<_ExpertiseCard> createState() => _ExpertiseCardState();
}

class _ExpertiseCardState extends State<_ExpertiseCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        width: 350,
        padding: const EdgeInsets.all(40),
        transform: Matrix4.translationValues(0, _isHovered ? -10.0 : 0, 0)
          ..multiply(Matrix4.diagonal3Values(_isHovered ? 1.02 : 1, _isHovered ? 1.02 : 1, 1)),
        decoration: BoxDecoration(
          color: isDark ? AppTheme.surface : Colors.white,
          borderRadius: BorderRadius.circular(32),
          border: Border.all(
            color: _isHovered
                ? AppTheme.secondary.withValues(alpha: 0.3)
                : (isDark
                    ? Colors.white.withValues(alpha: 0.05)
                    : Colors.black.withValues(alpha: 0.05)),
          ),
          boxShadow: [
            BoxShadow(
              color: _isHovered
                  ? AppTheme.secondary.withValues(alpha: 0.15)
                  : Colors.black.withValues(alpha: 0.1),
              blurRadius: _isHovered ? 40 : 20,
              offset: Offset(0, _isHovered ? 20 : 10),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _isHovered
                    ? AppTheme.secondary
                    : AppTheme.secondary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                widget.expertise.icon,
                color: _isHovered ? Colors.white : AppTheme.secondary,
                size: 32,
              ),
            ),
            const SizedBox(height: 32),
            Text(
              widget.expertise.title,
              style: theme.textTheme.headlineMedium?.copyWith(
                fontSize: 24,
                color: theme.textTheme.displayLarge?.color,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              widget.expertise.description,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontSize: 16,
                height: 1.6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
