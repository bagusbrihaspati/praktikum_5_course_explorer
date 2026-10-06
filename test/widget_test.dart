import 'package:flutter_test/flutter_test.dart';
import 'package:praktikum_5_course_explorer/main.dart';

void main() {
  testWidgets('Course Explorer smoke test', (WidgetTester tester) async {
    // 1. Ubah DebuggingChallengeApp menjadi CourseExplorerApp
    await tester.pumpWidget(const CourseExplorerApp());

    // 2. Sesuaikan teks pencarian dengan judul AppBar halaman utama ('Course Explorer - Home')
    expect(find.text('Course Explorer - Home'), findsOneWidget);
  });
}