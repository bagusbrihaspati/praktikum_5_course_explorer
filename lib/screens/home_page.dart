import 'package:flutter/material.dart';
import '../widgets/student_header_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;

    final List<String> skills = [
      'Flutter',
      'Dart',
      'Laravel',
      'PHP',
      'UI/UX Design',
      'Computer Network',
      'Digital Image Processing',
      'Git & GitHub'
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Course Explorer - Home')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const StudentHeaderCard(),
            const SizedBox(height: 16),
            Card(
              elevation: 1,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: Colors.blue.shade200),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Informasi Lingkungan Layar (MediaQuery):',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade900,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                        'Width: ${size.width.toStringAsFixed(0)} px | Height: ${size.height.toStringAsFixed(0)} px'),
                    Text('Orientation: ${orientation.name}'),
                    const SizedBox(height: 8),
                    Chip(
                      label: Text(
                        size.width < 600
                            ? 'Mode: Compact (< 600px)'
                            : 'Mode: Wide (>= 600px)',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade900,
                        ),
                      ),
                      backgroundColor: size.width < 600
                          ? Colors.blue.shade100
                          : Colors.lightBlue.shade100,
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Demo Proportion Flex Layout (2 : 1):',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade900,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade600,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      'Flex 2',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade300,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Flex 1',
                      style: TextStyle(
                        color: Colors.blue.shade900,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Keterampilan Utama (Wrap Widget):',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade900,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: skills.map((skill) {
                return Chip(
                  backgroundColor: Colors.blue.shade50,
                  side: BorderSide(color: Colors.blue.shade200),
                  avatar: Icon(
                    Icons.check_circle_outline,
                    size: 16,
                    color: Colors.blue.shade700,
                  ),
                  label: Text(
                    skill,
                    style: TextStyle(color: Colors.blue.shade900),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}