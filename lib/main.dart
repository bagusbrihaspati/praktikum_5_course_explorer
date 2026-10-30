import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/course_provider.dart';
import 'repositories/course_repository.dart';
import 'screens/courses_page.dart';
import 'screens/debugging_lab_page.dart';
import 'screens/home_page.dart';
import 'screens/profile_feedback_page.dart';
import 'screens/favorites_page.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'models/course.dart';
import 'services/course_api_service.dart';

const String studentName = 'I Ketut Bagus Brihaspati';
const String studentId = '2415051090';

const String apiUrl = 'https://jsonplaceholder.typicode.com/posts';

Future<List<Course>> fetchCourses() async {
  final response = await http.get(Uri.parse(apiUrl));

  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body);
    return data.map((item) => Course.fromJson(item as Map<String, dynamic>)).toList();
  }

  throw Exception('HTTP ${response.statusCode}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // URL API Latihan
  const String apiBaseUrl = 'https://jsonplaceholder.typicode.com/posts';

  // Rakit Service -> Repository -> Provider (Instruksi 55)
  final dataSource = CourseApiService(apiBaseUrl);
  final repository = CourseRepository(dataSource);

  runApp(
    ChangeNotifierProvider(
      create: (_) => CourseProvider(repository)..loadCourses(),
      child: const CourseExplorerApp(),
    ),
  );
}

class CourseExplorerApp extends StatelessWidget {
  const CourseExplorerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Course Explorer - $studentId',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          primary: Colors.blue.shade700,
          secondary: Colors.blueAccent,
          primaryContainer: Colors.blue.shade50,
          onPrimaryContainer: Colors.blue.shade900,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFA1E7FF),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue.shade700,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      home: const MainAdaptiveShell(),
    );
  }
}

class MainAdaptiveShell extends StatefulWidget {
  const MainAdaptiveShell({super.key});

  @override
  State<MainAdaptiveShell> createState() => _MainAdaptiveShellState();
}

class _MainAdaptiveShellState extends State<MainAdaptiveShell> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    HomePage(),
    CoursesPage(),
    FavoritesPage(), // Tahap 13: Tab baru khusus menampilkan mata kuliah favorit
    ProfileFeedbackPage(),
    DebuggingLabPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isExpanded = constraints.maxWidth >= 840;

        if (!isExpanded) {
          return Scaffold(
            body: SafeArea(child: _pages[_selectedIndex]),
            bottomNavigationBar: NavigationBar(
              backgroundColor: Colors.blue.shade50,
              indicatorColor: Colors.blue.shade200,
              selectedIndex: _selectedIndex,
              onDestinationSelected: (index) {
                setState(() => _selectedIndex = index);
              },
              destinations: [
                NavigationDestination(
                  icon: Icon(Icons.home_outlined, color: Colors.blue.shade900),
                  selectedIcon: Icon(Icons.home, color: Colors.blue.shade900),
                  label: 'Home',
                ),
                NavigationDestination(
                  icon: Icon(Icons.school_outlined, color: Colors.blue.shade900),
                  selectedIcon: Icon(Icons.school, color: Colors.blue.shade900),
                  label: 'Courses',
                ),
                NavigationDestination(
                  icon: Icon(Icons.favorite_border, color: Colors.blue.shade900),
                  selectedIcon: Icon(Icons.favorite, color: Colors.blue.shade900),
                  label: 'Favorites',
                ),
                NavigationDestination(
                  icon: Icon(Icons.person_outlined, color: Colors.blue.shade900),
                  selectedIcon: Icon(Icons.person, color: Colors.blue.shade900),
                  label: 'Profile',
                ),
                NavigationDestination(
                  icon: Icon(Icons.bug_report_outlined, color: Colors.blue.shade900),
                  selectedIcon: Icon(Icons.bug_report, color: Colors.blue.shade900),
                  label: 'Debug Lab',
                ),
              ],
            ),
          );
        } else {
          return Scaffold(
            body: Row(
              children: [
                NavigationRail(
                  backgroundColor: Colors.blue.shade50,
                  indicatorColor: Colors.blue.shade200,
                  selectedIndex: _selectedIndex,
                  onDestinationSelected: (index) {
                    setState(() => _selectedIndex = index);
                  },
                  labelType: NavigationRailLabelType.all,
                  leading: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.blue.shade700,
                      child: const Icon(Icons.menu_book, color: Colors.white),
                    ),
                  ),
                  destinations: const [
                    NavigationRailDestination(
                      icon: Icon(Icons.home_outlined),
                      selectedIcon: Icon(Icons.home),
                      label: Text('Home'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.school_outlined),
                      selectedIcon: Icon(Icons.school),
                      label: Text('Courses'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.favorite_border),
                      selectedIcon: Icon(Icons.favorite),
                      label: Text('Favorites'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.person_outlined),
                      selectedIcon: Icon(Icons.person),
                      label: Text('Profile'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.bug_report_outlined),
                      selectedIcon: Icon(Icons.bug_report),
                      label: Text('Debug Lab'),
                    ),
                  ],
                ),
                const VerticalDivider(thickness: 1, width: 1),
                Expanded(child: _pages[_selectedIndex]),
              ],
            ),
          );
        }
      },
    );
  }
}