import 'package:flutter_test/flutter_test.dart';
import 'package:praktikum_5_course_explorer/main.dart';

void main() {
  testWidgets('KosFinder smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const KosFinderApp());
  });
}