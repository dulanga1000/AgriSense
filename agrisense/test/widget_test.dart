import 'package:flutter_test/flutter_test.dart';

import 'package:agrisense/main.dart';

void main() {
  testWidgets('App builds smoke test', (WidgetTester tester) async {
    // Verify the root app widget renders without throwing.
    await tester.pumpWidget(const MyApp());
    await tester.pump(const Duration(seconds: 4));

    expect(find.byType(MyApp), findsOneWidget);
  });
}
