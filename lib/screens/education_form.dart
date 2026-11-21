import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';

// Form edukasi menyimpan isian sementara, belum terhubung ke server.
class EducationFormPage extends StatefulWidget {
  const EducationFormPage({super.key});

  @override
  State<EducationFormPage> createState() => _EducationFormPageState();
}

class _EducationFormPageState extends State<EducationFormPage> {
  final _formKey = GlobalKey<FormState>();
  String _institusi = '';
  String _programStudi = '';
  String _jenjang = 'S1';

  String? _validasiTeks(String? nilai, String label) {
    final teks = nilai?.trim() ?? '';
    if (teks.isEmpty) return '$label wajib diisi, bukan hanya spasi.';
    if (teks.length > 100) return '$label maksimal 100 karakter.';
    return null;
  }

  void _simpan() {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Ringkasan Edukasi'),
        content: SingleChildScrollView(
          child: Text(
            'Institusi: $_institusi\nProgram Studi: $_programStudi\nJenjang: $_jenjang',
          ),
        ),
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
    final warna = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Edukasi'),
        backgroundColor: warna.primary,
        foregroundColor: warna.onPrimary,
      ),
      drawer: const LeftDrawer(),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Isi riwayat pendidikan kamu. Semua kolom wajib diisi.',
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Nama Institusi',
                    border: OutlineInputBorder(),
                  ),
                  textCapitalization: TextCapitalization.words,
                  validator: (nilai) => _validasiTeks(nilai, 'Nama institusi'),
                  onSaved: (nilai) => _institusi = nilai!.trim(),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Program Studi',
                    border: OutlineInputBorder(),
                  ),
                  validator: (nilai) => _validasiTeks(nilai, 'Program studi'),
                  onSaved: (nilai) => _programStudi = nilai!.trim(),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  initialValue: _jenjang,
                  decoration: const InputDecoration(
                    labelText: 'Jenjang Pendidikan',
                    border: OutlineInputBorder(),
                  ),
                  items: ['D3', 'D4', 'S1', 'S2', 'S3']
                      .map(
                        (nilai) =>
                            DropdownMenuItem(value: nilai, child: Text(nilai)),
                      )
                      .toList(),
                  validator: (nilai) =>
                      nilai == null ? 'Pilih jenjang pendidikan.' : null,
                  onChanged: (nilai) => setState(() => _jenjang = nilai!),
                ),
                const SizedBox(height: 24),
                ElevatedButton(onPressed: _simpan, child: const Text('Simpan')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
