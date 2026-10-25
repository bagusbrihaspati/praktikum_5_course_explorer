import 'package:flutter/material.dart';
import '../widgets/student_header_card.dart';

class ProfileFeedbackPage extends StatefulWidget {
  const ProfileFeedbackPage({super.key});

  @override
  State<ProfileFeedbackPage> createState() => _ProfileFeedbackPageState();
}

class _ProfileFeedbackPageState extends State<ProfileFeedbackPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _idController;
  final TextEditingController _commentsController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: studentName);
    _idController = TextEditingController(text: studentId);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _idController.dispose();
    _commentsController.dispose();
    super.dispose();
  }

  void _submitFeedback() async {
    if (_formKey.currentState!.validate()) {
      final bool? confirm = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            'Konfirmasi Pengiriman',
            style: TextStyle(color: Colors.blue.shade900),
          ),
          content: Text(
            'Apakah Anda yakin ingin mengirim feedback atas nama ${_nameController.text}?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade700,
                foregroundColor: Colors.white,
              ),
              child: const Text('Kirim'),
            ),
          ],
        ),
      );

      if (confirm == true) {
        setState(() => _isLoading = true);
        await Future.delayed(const Duration(seconds: 2));

        if (mounted) {
          setState(() => _isLoading = false);
          _commentsController.clear();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Terima kasih! Feedback dari ${_nameController.text} ($studentId) berhasil dikirim.',
              ),
              backgroundColor: Colors.blue.shade800,
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profil & Form Umpan Balik')),
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
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Formulir Evaluasi Course Explorer',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.blue.shade900,
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          labelText: 'Nama Mahasiswa',
                          prefixIcon:
                              Icon(Icons.person, color: Colors.blue.shade700),
                          border: const OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Nama wajib diisi';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _idController,
                        decoration: InputDecoration(
                          labelText: 'NIM Mahasiswa',
                          prefixIcon:
                              Icon(Icons.badge, color: Colors.blue.shade700),
                          border: const OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'NIM wajib diisi';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _commentsController,
                        maxLines: 3,
                        decoration: InputDecoration(
                          labelText: 'Komentar / Feedback Praktikum',
                          prefixIcon:
                              Icon(Icons.feedback, color: Colors.blue.shade700),
                          border: const OutlineInputBorder(),
                          hintText: 'Tuliskan masukan minimal 5 karakter...',
                        ),
                        validator: (value) {
                          if (value == null || value.trim().length < 5) {
                            return 'Komentar wajib terisi minimal 5 karakter';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _submitFeedback,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue.shade700,
                            foregroundColor: Colors.white,
                          ),
                          child: _isLoading
                              ? const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(width: 12),
                                    Text('Mengirim...'),
                                  ],
                                )
                              : const Text('Kirim Feedback'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}