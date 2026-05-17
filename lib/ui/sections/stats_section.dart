import 'package:flutter/material.dart';
import 'package:portfolio_web/data/portfolio_data.dart';
import 'package:portfolio_web/theme/app_theme.dart';

class StatsSection extends StatelessWidget {
  const StatsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 800;
        final isDark = Theme.of(context).brightness == Brightness.dark;
        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: isMobile ? 40 : 60),
          decoration: BoxDecoration(
            color: isDark
                ? Colors.white.withValues(alpha: 0.02)
                : Colors.black.withValues(alpha: 0.02),
            border: Border.symmetric(
              horizontal: BorderSide(
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.05)
                      : Colors.black.withValues(alpha: 0.05)),
            ),
          ),
          child: Wrap(
            alignment: WrapAlignment.spaceEvenly,
            spacing: isMobile ? 20 : 40,
            runSpacing: isMobile ? 32 : 40,
            children: PortfolioData.stats.asMap().entries.map((entry) {
              final index = entry.key;
              final stat = entry.value;

              return _AnimatedStatItem(
                stat: stat,
                index: index,
                isMobile: isMobile,
              );
            }).toList(),
          ),
        );
      },
    );
  }
}

class _AnimatedStatItem extends StatefulWidget {
  const _AnimatedStatItem({
    required this.stat,
    required this.index,
    required this.isMobile,
  });
  final Map<String, String> stat;
  final int index;
  final bool isMobile;

  @override
  State<_AnimatedStatItem> createState() => _AnimatedStatItemState();
}

class _AnimatedStatItemState extends State<_AnimatedStatItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeOutExpo);

    Future.delayed(Duration(milliseconds: 400 + (widget.index * 150)), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.isMobile
          ? (MediaQuery.of(context).size.width / 2) - 30
          : null,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Opacity(
            opacity: _animation.value,
            child: Transform.translate(
              offset: Offset(0, 20 * (1 - _animation.value)),
              child: child,
            ),
          );
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.stat['value']!,
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    fontSize: widget.isMobile ? 32 : 56,
                    color: AppTheme.secondary,
                    fontWeight: FontWeight.w900,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.stat['label']!.toUpperCase(),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontSize: widget.isMobile ? 10 : 12,
                    letterSpacing: 2,
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
