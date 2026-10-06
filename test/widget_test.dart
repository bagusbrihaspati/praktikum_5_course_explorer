import 'package:flutter_test/flutter_test.dart';
import 'package:praktikum_5_course_explorer/main.dart';

void main() {
  testWidgets('Course Explorer smoke test', (WidgetTester tester) async {
    // Build aplikasi CourseExplorerApp
    await tester.pumpWidget(const DebuggingChallengeApp());

    // Verifikasi bahwa judul AppBar 'Course Explorer' muncul di layar
    expect(find.text('Course Explorer'), findsOneWidget);
  });
}