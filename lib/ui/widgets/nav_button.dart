import 'package:flutter/material.dart';

class NavButton extends StatefulWidget {
  const NavButton({
    required this.text,
    required this.onTap,
    super.key,
  });
  final String text;
  final VoidCallback onTap;

  @override
  State<NavButton> createState() => _NavButtonState();
}

class _NavButtonState extends State<NavButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(left: 24),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 200),
            style: theme.textTheme.labelLarge!.copyWith(
              color: _isHovered
                  ? theme.colorScheme.primary
                  : theme.textTheme.bodyMedium?.color,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.text),
                const SizedBox(height: 2),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: 2,
                  width: _isHovered ? 20 : 0,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
