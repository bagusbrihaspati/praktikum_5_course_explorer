import 'package:flutter/material.dart';

const String studentName = 'I Ketut Bagus Brihaspati';
const String studentId = '2415051090';

class StudentHeaderCard extends StatefulWidget {
  const StudentHeaderCard({super.key});

  @override
  State<StudentHeaderCard> createState() => _StudentHeaderCardState();
}

class _StudentHeaderCardState extends State<StudentHeaderCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: Colors.blue.shade100,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.blue.shade300),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: Colors.blue.shade700,
                  child: const Icon(Icons.person, color: Colors.white, size: 30),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        studentName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.blue.shade900,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'NIM: $studentId | Class: PTI 5A',
                        style: TextStyle(color: Colors.blue.shade800),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(
                    _isExpanded ? Icons.expand_less : Icons.expand_more,
                    color: Colors.blue.shade900,
                  ),
                  onPressed: () {
                    setState(() {
                      _isExpanded = !_isExpanded;
                    });
                  },
                ),
              ],
            ),
            if (_isExpanded) ...[
              const Divider(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Status: Mahasiswa Aktif PTI Undiksha\nFokus: Pemrograman Mobile, UI/UX & Rekayasa Web',
                  style: TextStyle(fontSize: 12, color: Colors.blue.shade900),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}