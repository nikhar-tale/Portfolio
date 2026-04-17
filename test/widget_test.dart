import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio_web/main.dart';

void main() {
  testWidgets('Portfolio loads smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const PortfolioApp());

    // Verify that the app builds successfully.
    expect(find.byType(PortfolioApp), findsOneWidget);
  });
}
