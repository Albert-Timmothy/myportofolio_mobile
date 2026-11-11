import 'package:flutter_test/flutter_test.dart';
import 'package:myportofolio_mobile/main.dart';

void main() {
  testWidgets('Menu shows identity and feedback for every action', (
    tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('Albert'), findsOneWidget);
    expect(find.text('2506656381'), findsOneWidget);
    expect(find.text('PBP F'), findsOneWidget);

    for (final label in ['Lihat Proyek', 'Tambah Proyek', 'Logout']) {
      await tester.tap(find.text(label));
      await tester.pumpAndSettle();
      expect(find.text('Kamu telah menekan tombol $label!'), findsOneWidget);
      await tester.pump(const Duration(seconds: 5));
      await tester.pumpAndSettle();
    }
    expect(tester.takeException(), isNull);
  });
}

