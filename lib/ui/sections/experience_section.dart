import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio_web/data/portfolio_data.dart';
import 'package:portfolio_web/theme/app_theme.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 800;

        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 24 : 100,
            vertical: 100,
          ),
          width: double.infinity,
          color: AppTheme.surface, // Dark Gray Apple-esque surface
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Experience",
                style: GoogleFonts.outfit(
                  fontSize: isMobile ? 40 : 64,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: -2,
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

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        margin: const EdgeInsets.only(bottom: 24),
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: _isHovered ? Colors.white.withOpacity(0.02) : Colors.transparent,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: _isHovered ? Colors.white.withOpacity(0.1) : Colors.transparent,
          ),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: AppTheme.primary.withOpacity(0.05),
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
                  _buildHeader(),
                  const SizedBox(height: 24),
                  _buildDetails(),
                ],
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 250,
                    child: _buildHeader(),
                  ),
                  Expanded(
                    child: _buildDetails(),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: _isHovered ? AppTheme.secondary.withOpacity(0.1) : Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
              color: _isHovered ? AppTheme.secondary.withOpacity(0.3) : Colors.white.withOpacity(0.05),
            ),
          ),
          child: Text(
            widget.experience['duration'],
            style: GoogleFonts.inter(
              fontSize: 12,
              color: _isHovered ? AppTheme.secondary : AppTheme.textSecondary,
              fontWeight: FontWeight.w600,
              letterSpacing: 1,
            ),
          ),
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            Icon(Icons.business, size: 20, color: _isHovered ? Colors.white : AppTheme.textSecondary),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                widget.experience['company'],
                style: GoogleFonts.inter(
                  fontSize: 20,
                  color: _isHovered ? Colors.white : Colors.white.withOpacity(0.8),
                  fontWeight: FontWeight.bold,
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

  Widget _buildDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 300),
          style: GoogleFonts.outfit(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: _isHovered ? AppTheme.secondary : Colors.white,
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
                    color: _isHovered ? AppTheme.secondary : AppTheme.textSecondary,
                  ),
                ),
                Expanded(
                  child: AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 300),
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      color: _isHovered ? Colors.white.withOpacity(0.9) : AppTheme.textSecondary,
                      height: 1.6,
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
