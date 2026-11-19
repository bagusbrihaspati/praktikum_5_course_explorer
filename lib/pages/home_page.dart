import '../services/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../services/auth_service.dart';
import '../services/kos_service.dart';
import '../services/profile_service.dart';
import '../widgets/role_guard.dart';
import 'login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final Future<UserProfile?> _profileFuture;
  final _kosService = KosService();

@override
  void initState() {
    super.initState();
    _profileFuture = ProfileService().getMyProfile();
    NotificationService.instance.init();
  }

  Future<void> _logout() async {
    await AuthService.instance.logout();
    if (!mounted) return;
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const LoginPage()),
      (route) => false,
    );
  }

  Future<void> _initNotifications() async {
    await NotificationService.instance.requestPermission();
    final token = await NotificationService.instance.getToken();
    if (token != null) {
      await NotificationService.instance.saveTokenToSupabase(token);
    }
    NotificationService.instance.listenTokenRefresh((newToken) {
      NotificationService.instance.saveTokenToSupabase(newToken);
    });
  }

  Future<void> _showAddOrEditDialog({Map? existing}) async {
    final nameC = TextEditingController(text: existing?['name'] ?? '');
    final addrC = TextEditingController(text: existing?['address'] ?? '');
    final priceC = TextEditingController(
      text: existing?['price']?.toString() ?? '',
    );

    final saved = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(existing == null ? 'Tambah Kos' : 'Edit Kos'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameC,
              decoration: const InputDecoration(labelText: 'Nama Kos'),
            ),
            TextField(
              controller: addrC,
              decoration: const InputDecoration(labelText: 'Alamat'),
            ),
            TextField(
              controller: priceC,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Harga / Bulan'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () async {
              final name = nameC.text.trim();
              final addr = addrC.text.trim();
              final price = int.tryParse(priceC.text.trim()) ?? 0;
              if (name.isEmpty) return;

              if (existing == null) {
                await _kosService.add(name: name, address: addr, price: price);
              } else {
                await _kosService.update(existing['id'], {
                  'name': name,
                  'address': addr,
                  'price': price,
                });
              }
              if (ctx.mounted) Navigator.pop(ctx, true);
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );

    if (saved == true && mounted) setState(() {});
  }

  // Pengujian Praktik 6 — Security Testing (User B mencoba akses data User A)
  Future<void> _securityTest(
    String kosIdMilikUserA,
    String ownerIdMilikUserA,
  ) async {
    final logs = <String>[];

    // 1. User B mencoba mengubah data User A -> harus DENIED
    final updated =
        await _kosService.update(kosIdMilikUserA, {'name': 'DIUBAH USER B'});
    final msg1 = updated
        ? '[FAIL] User B berhasil mengubah data User A'
        : '[PASS] UPDATE ditolak oleh RLS';
    debugPrint(msg1);
    logs.add(msg1);

    // 2. User B mencoba menghapus data User A -> harus DENIED
    final deleted = await _kosService.delete(kosIdMilikUserA);
    final msg2 = deleted
        ? '[FAIL] User B berhasil menghapus data User A'
        : '[PASS] DELETE ditolak oleh RLS';
    debugPrint(msg2);
    logs.add(msg2);

    // 3. User B mencoba INSERT atas nama User A -> harus ERROR 42501
    try {
      await Supabase.instance.client.from('kos').insert({
        'owner_id': ownerIdMilikUserA,
        'name': 'Kos palsu',
      });
      const msg3 = '[FAIL] INSERT atas nama user lain berhasil';
      debugPrint(msg3);
      logs.add(msg3);
    } on PostgrestException catch (e) {
      final msg3 = '[PASS] INSERT ditolak: ${e.code} - ${e.message}';
      debugPrint(msg3);
      logs.add(msg3);
    }

    if (!mounted) return;
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Hasil Security Testing RLS'),
        content: Text(logs.join('\n\n')),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final myId = Supabase.instance.client.auth.currentUser?.id;

    return FutureBuilder<UserProfile?>(
      future: _profileFuture,
      builder: (context, snap) {
        if (snap.connectionState != ConnectionState.done) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        final p = snap.data;
        if (snap.hasError || p == null) {
          return const Scaffold(
            body: Center(child: Text('Gagal memuat profil')),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: Text('KosFinder (${p.role})'),
            actions: [
              IconButton(
                tooltip: 'Logout',
                icon: const Icon(Icons.logout),
                onPressed: _logout,
              ),
            ],
          ),
          body: FutureBuilder<List<dynamic>>(
            future: _kosService.fetchAll(),
            builder: (context, kosSnap) {
              final items = kosSnap.data ?? [];
              return ListView(
                children: [
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: Text(p.name.isEmpty ? p.email : p.name),
                    subtitle: Text('${p.email} • ${p.role}'),
                  ),
                  const Divider(),
                  const ListTile(
                    leading: Icon(Icons.list),
                    title: Text('Daftar Kos'),
                  ),
                  if (kosSnap.connectionState == ConnectionState.waiting)
                    const Center(child: CircularProgressIndicator())
                  else if (items.isEmpty)
                    const Padding(
                      padding: EdgeInsets.all(16),
                      child: Text('Belum ada data kos.'),
                    )
                  else
                    ...items.map((kos) {
                      final isMine = kos['owner_id'] == myId;
                      return ListTile(
                        title: Text(kos['name'] ?? '-'),
                        subtitle: Text(
                          '${kos['address'] ?? '-'} • Rp ${kos['price'] ?? 0}',
                        ),
                        trailing: isMine
                            ? Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.edit),
                                    onPressed: () =>
                                        _showAddOrEditDialog(existing: kos),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () async {
                                      await _kosService.delete(kos['id']);
                                      if (mounted) setState(() {});
                                    },
                                  ),
                                ],
                              )
                            : TextButton.icon(
                                icon: const Icon(Icons.security, size: 18),
                                label: const Text('Test RLS'),
                                onPressed: () => _securityTest(
                                  kos['id'],
                                  kos['owner_id'],
                                ),
                              ),
                      );
                    }),
                ],
              );
            },
          ),
          floatingActionButton: RoleGuard(
            role: p.role,
            allowed: const ['owner', 'admin'],
            child: FloatingActionButton.extended(
              onPressed: () => _showAddOrEditDialog(),
              icon: const Icon(Icons.add_home),
              label: const Text('Tambah Kos'),
            ),
          ),
        );
      },
    );
  }
}