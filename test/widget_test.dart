import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio_web/main.dart';

void main() {
  testWidgets('Portfolio loads smoke test', (WidgetTester tester) async {
    // Set a desktop-class viewport for the test
    tester.view.physicalSize = const Size(1920, 1080);
    tester.view.devicePixelRatio = 1.0;

    // Build our app and trigger a frame.
    await tester.pumpWidget(const PortfolioApp());
    
    // Initial pump to start timers
    await tester.pump();

    // Verify that the app builds successfully.
    expect(find.byType(PortfolioApp), findsOneWidget);
    
    // Advance time to handle staggered animations and clear pending timers
    // This prevents the "Timer is still pending" error.
    await tester.pump(const Duration(seconds: 5));
    
    // Reset the view after the test
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });
  });
}
