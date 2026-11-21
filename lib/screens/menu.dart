import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';
import 'package:myportofolio_mobile/widgets/project_card.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  final String npm = '2506656381';
  final String nama = 'Albert Timmothy Ariajaya';
  final String kelas = 'PBP F';

  static const List<ItemHomepage> items = [
    ItemHomepage('Lihat Proyek', Icons.folder, Color(0xFF1565C0)),
    ItemHomepage('Tambah Proyek', Icons.add_circle, Color(0xFF2E7D32)),
    ItemHomepage('Tambah Edukasi', Icons.school, Color(0xFF6A1B9A)),
    ItemHomepage('Logout', Icons.logout, Color(0xFFC62828)),
  ];

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'MyPortfolio',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: colors.primary,
        foregroundColor: colors.onPrimary,
      ),
      drawer: const LeftDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: InfoCard(title: 'NPM', content: npm),
                ),
                Expanded(
                  child: InfoCard(title: 'Name', content: nama),
                ),
                Expanded(
                  child: InfoCard(title: 'Class', content: kelas),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(top: 32, bottom: 16),
              child: Text(
                'Selamat datang di MyPortfolio Mobile!',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            GridView.count(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              mainAxisExtent: 160,
              padding: const EdgeInsets.symmetric(vertical: 20),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: items.map((item) => ItemCard(item)).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final String title;
  final String content;

  const InfoCard({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(content, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}

class ItemHomepage {
  final String name;
  final IconData icon;

  // Warna merupakan data tiap menu, bukan percabangan di widget kartu.
  final Color color;

  const ItemHomepage(this.name, this.icon, this.color);
}
