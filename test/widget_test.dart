import 'package:flutter_test/flutter_test.dart';
import 'package:intern_insight/main.dart';

void main() {
  testWidgets('App starts on Login', (tester) async {
    await tester.pumpWidget(const InternInsightApp());
    expect(find.text('InternInsight'), findsOneWidget);
    expect(find.text('Log in'), findsOneWidget);
  });
}
