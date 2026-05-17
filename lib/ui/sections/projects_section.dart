import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio_web/data/portfolio_data.dart';
import 'package:portfolio_web/models/project.dart';
import 'package:portfolio_web/theme/app_theme.dart';
import 'package:portfolio_web/utils/url_utils.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

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
                  'Featured Work',
                  style: theme.textTheme.displaySmall?.copyWith(
                    fontSize: isMobile ? 40 : 64,
                  ),
                ),
              ),
              const SizedBox(height: 80),
              Container(
                constraints: const BoxConstraints(maxWidth: 1200),
                child: Column(
                  children: PortfolioData.projects.map((project) {
                    return _ProjectCard(project: project);
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

class _ProjectCard extends StatefulWidget {
  const _ProjectCard({required this.project});
  final Project project;

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 900;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Semantics(
      label: 'Project: ${widget.project.title}. ${widget.project.description}',
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOutCubic,
          margin: const EdgeInsets.only(bottom: 64),
          transform: Matrix4.translationValues(0, _isHovered ? -15.0 : 0, 0),
          decoration: BoxDecoration(
            color: isDark ? AppTheme.surface : Colors.white,
            borderRadius: BorderRadius.circular(40),
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
                    ? AppTheme.secondary.withValues(alpha: 0.2)
                    : Colors.black.withValues(alpha: 0.2),
                blurRadius: _isHovered ? 60 : 40,
                offset: Offset(0, _isHovered ? 30 : 20),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: isMobile
                ? Column(
                    children: [
                      _buildImage(isMobile),
                      _buildContent(theme, isMobile),
                    ],
                  )
                : Row(
                    children: [
                      Expanded(flex: 5, child: _buildImage(isMobile)),
                      Expanded(flex: 6, child: _buildContent(theme, isMobile)),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildImage(bool isMobile) {
    return Container(
      height: isMobile ? 300 : 500,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppTheme.background,
        image: DecorationImage(
          image: AssetImage(widget.project.imageUrl),
          fit: BoxFit.cover,
          opacity: _isHovered ? 0.95 : 0.7,
        ),
      ),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        color: _isHovered
            ? AppTheme.primary.withValues(alpha: 0.05)
            : Colors.transparent,
        child: _isHovered ? const Center(child: Icon(Icons.open_in_new, color: Colors.white, size: 48)) : null,
      ),
    );
  }

  Widget _buildContent(ThemeData theme, bool isMobile) {
    return Padding(
      padding: EdgeInsets.all(isMobile ? 32 : 64),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: _isHovered ? AppTheme.secondary : AppTheme.secondary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Text(
                  'Project',
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: _isHovered ? Colors.white : AppTheme.secondary,
                    fontSize: 12,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            widget.project.title,
            style: theme.textTheme.displaySmall?.copyWith(
              fontSize: isMobile ? 32 : 48,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            widget.project.description,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: AppTheme.textSecondary,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 32),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: widget.project.tech.map((tag) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Text(
                  tag,
                  style: theme.textTheme.labelLarge?.copyWith(fontSize: 12),
                ),
              ).semanticsCheckue(label: 'Technology used: $tag');
            }).toList(),
          ),
          const SizedBox(height: 48),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              if (widget.project.playStoreUrl != null)
                _LinkButton(
                  icon: Icons.android,
                  label: 'Play Store',
                  url: widget.project.playStoreUrl!,
                ),
              if (widget.project.appStoreUrl != null)
                _LinkButton(
                  icon: Icons.apple,
                  label: 'App Store',
                  url: widget.project.appStoreUrl!,
                ),
            ],
          ),
        ],
      ),
    );
  }
}

extension on Widget {
  Widget semanticsCheckue({required String label}) {
    return Semantics(label: label, child: this);
  }
}

class _LinkButton extends StatelessWidget {
  const _LinkButton({
    required this.icon,
    required this.label,
    required this.url,
  });
  final IconData icon;
  final String label;
  final String url;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => UrlUtils.launch(url),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          decoration: BoxDecoration(
            color: isDark ? Colors.white : Colors.black,
            borderRadius: BorderRadius.circular(100),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 18,
                color: isDark ? Colors.black : Colors.white,
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: GoogleFonts.inter(
                  color: isDark ? Colors.black : Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
