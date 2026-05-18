import 'package:flutter/material.dart';

class NavigationProvider extends ChangeNotifier {
  final ScrollController scrollController = ScrollController();

  final GlobalKey projectsKey = GlobalKey();
  final GlobalKey experienceKey = GlobalKey();
  final GlobalKey contactKey = GlobalKey();

  void scrollTo(GlobalKey key) {
    // Ensure we scroll after the next frame to avoid race conditions
    // with other layout changes (like closing the mobile menu).
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!scrollController.hasClients) return;

      final context = key.currentContext;
      if (context != null) {
        final renderBox = context.findRenderObject() as RenderBox?;
        if (renderBox != null && renderBox.attached && renderBox.hasSize) {
          final position = renderBox.localToGlobal(Offset.zero);
          final currentOffset = scrollController.offset;
          final target = currentOffset + position.dy - 120;

          final maxScroll = scrollController.position.maxScrollExtent;

          scrollController.animateTo(
            target.clamp(0.0, maxScroll),
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeInOutCubic,
          );
        }
      }
    });
    notifyListeners();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
