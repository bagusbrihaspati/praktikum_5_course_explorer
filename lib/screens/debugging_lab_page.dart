import 'package:flutter/material.dart';
import '../widgets/student_header_card.dart';

class DebuggingLabPage extends StatefulWidget {
  const DebuggingLabPage({super.key});

  @override
  State<DebuggingLabPage> createState() => _DebuggingLabPageState();
}

class _DebuggingLabPageState extends State<DebuggingLabPage> {
  bool _isNavigating = false;

  void _safeNavigate() async {
    if (_isNavigating) return;
    setState(() => _isNavigating = true);

    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(title: const Text('Demo Anti-Double Push')),
          body: const Center(
            child: Text('Halaman berhasil dibuka dengan aman!'),
          ),
        ),
      ),
    );

    if (mounted) {
      setState(() => _isNavigating = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Debugging Challenge Lab')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const StudentHeaderCard(),
            const SizedBox(height: 16),
            Text(
              '1. Solusi Row Text Overflow (Expanded Wrapper):',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade900,
              ),
            ),
            const SizedBox(height: 8),
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: Colors.blue.shade200),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Icon(Icons.info, color: Colors.blue.shade700),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        '$studentId - $studentName - Teks yang sangat panjang ini tidak akan memicu RenderFlex Overflow karena telah dibungkus dengan widget Expanded secara tepat.',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.blue.shade900,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              '2. Solusi Unbounded ListView dalam Column:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade900,
              ),
            ),
            const SizedBox(height: 8),
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: Colors.blue.shade200),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: SizedBox(
                  height: 120,
                  child: ListView.builder(
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return ListTile(
                        dense: true,
                        leading: Icon(
                          Icons.check_circle,
                          size: 18,
                          color: Colors.blue.shade700,
                        ),
                        title: Text(
                          'Item Terisolasi ${index + 1}',
                          style: TextStyle(color: Colors.blue.shade900),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              '3. Solusi Mencegah Navigasi Ganda (Double Push Guard):',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade900,
              ),
            ),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: _isNavigating ? null : _safeNavigate,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade700,
                foregroundColor: Colors.white,
              ),
              icon: const Icon(Icons.touch_app),
              label: Text(
                _isNavigating
                    ? 'Sedang Membuka...'
                    : 'Uji Proteksi Double Tap Navigation',
              ),
            ),
          ],
        ),
      ),
    );
  }
}