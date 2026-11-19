import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'pages/login_page.dart';
import 'providers/course_provider.dart';
import 'repositories/course_repository.dart';
import 'services/course_supabase_service.dart';

const String studentName = 'I Ketut Bagus Brihaspati';
const String studentId = '2415051090';

// Konfigurasi Supabase
const String supabaseUrl = 'https://znrjokqbhjmyfafrsqpa.supabase.co';
const String supabaseAnonKey = 'sb_publishable_IyadaeSzSGBRKgmcf8YdBg_jSozk9Yj';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseAnonKey,
  );

  final dataSource = CourseSupabaseService();
  final repository = CourseRepository(dataSource);

  runApp(
    ChangeNotifierProvider(
      create: (_) => CourseProvider(repository)..loadCourses(),
      child: const KosFinderApp(),
    ),
  );
}

class KosFinderApp extends StatelessWidget {
  const KosFinderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KosFinder - $studentId',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.indigo,
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
}