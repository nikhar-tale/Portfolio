import 'package:flutter/material.dart';
import 'package:portfolio_web/data/portfolio_data.dart';
import 'package:portfolio_web/theme/app_theme.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

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
          color: theme.colorScheme.surface,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Semantics(
                header: true,
                child: Text(
                  "Experience",
                  style: theme.textTheme.displaySmall?.copyWith(
                    fontSize: isMobile ? 40 : 64,
                  ),
                ),
              ),
              const SizedBox(height: 80),
              Container(
                constraints: const BoxConstraints(maxWidth: 800),
                child: Column(
                  children: PortfolioData.experience.map((exp) {
                    return _ExperienceRow(experience: exp, isMobile: isMobile);
                  }).toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ExperienceRow extends StatefulWidget {
  final Map<String, dynamic> experience;
  final bool isMobile;

  const _ExperienceRow({required this.experience, required this.isMobile});

  @override
  State<_ExperienceRow> createState() => _ExperienceRowState();
}

class _ExperienceRowState extends State<_ExperienceRow> {
  bool _isHovered = false;
  bool get _active => _isHovered || widget.isMobile;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Semantics(
      label: "Professional experience at ${widget.experience['company']} as ${widget.experience['role']} from ${widget.experience['duration']}",
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isHovered = true),
        onTapUp: (_) => setState(() => _isHovered = false),
        onTapCancel: () => setState(() => _isHovered = false),
        child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
          margin: const EdgeInsets.only(bottom: 24),
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: _active 
              ? (isDark ? Colors.white.withValues(alpha: 0.02) : Colors.black.withValues(alpha: 0.02))
              : Colors.transparent,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: _active 
                ? (isDark ? Colors.white.withValues(alpha: 0.1) : Colors.black.withValues(alpha: 0.05))
                : Colors.transparent,
            ),
            boxShadow: _active
                ? [
                    BoxShadow(
                      color: AppTheme.primary.withValues(alpha: 0.05),
                      blurRadius: 30,
                      offset: const Offset(0, 10),
                    )
                  ]
                : [],
          ),
          child: widget.isMobile
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(theme, isDark),
                    const SizedBox(height: 24),
                    _buildDetails(theme, isDark),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 250,
                      child: _buildHeader(theme, isDark),
                    ),
                    Expanded(
                      child: _buildDetails(theme, isDark),
                    ),
                  ],
                ),
        ),
      )),
    );
  }

  Widget _buildHeader(ThemeData theme, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: _active ? AppTheme.secondary.withValues(alpha: 0.1) : (isDark ? Colors.white.withValues(alpha: 0.05) : Colors.black.withValues(alpha: 0.05)),
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
              color: _active ? AppTheme.secondary.withValues(alpha: 0.3) : (isDark ? Colors.white.withValues(alpha: 0.05) : Colors.black.withValues(alpha: 0.05)),
            ),
          ),
          child: Text(
            widget.experience['duration'],
            style: theme.textTheme.labelLarge?.copyWith(
              fontSize: 12,
              color: _active ? AppTheme.secondary : theme.textTheme.bodyMedium?.color,
              letterSpacing: 1,
            ),
          ),
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            Icon(Icons.business, size: 20, color: _active ? theme.textTheme.displayLarge?.color : theme.textTheme.bodyMedium?.color),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                widget.experience['company'],
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontSize: 20,
                  color: _active ? theme.textTheme.displayLarge?.color : theme.textTheme.displayLarge?.color?.withValues(alpha: 0.8),
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDetails(ThemeData theme, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 300),
          style: theme.textTheme.headlineMedium!.copyWith(
            fontSize: 24,
            color: _active ? AppTheme.secondary : theme.textTheme.displayLarge?.color,
          ),
          child: Text(widget.experience['role']),
        ),
        const SizedBox(height: 24),
        ...(widget.experience['bullets'] as List<String>).map((bullet) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.only(top: 8, right: 16),
                  child: Icon(
                    Icons.arrow_right_rounded,
                    size: 20,
                    color: _active ? AppTheme.secondary : theme.textTheme.bodyMedium?.color,
                  ),
                ),
                Expanded(
                  child: AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 300),
                    style: theme.textTheme.bodyMedium!.copyWith(
                      color: _active ? theme.textTheme.displayLarge?.color?.withValues(alpha: 0.9) : theme.textTheme.bodyMedium?.color,
                    ),
                    child: Text(bullet),
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}
