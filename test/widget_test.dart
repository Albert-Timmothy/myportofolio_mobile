import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/menu.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myportofolio_mobile/main.dart';

void main() {
  testWidgets('Menu shows identity and feedback for every action', (
    tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('Albert Timmothy Ariajaya'), findsOneWidget);
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
  testWidgets(
    'Action cards use distinct backgrounds and readable foregrounds',
    (tester) async {
      await tester.pumpWidget(const MyApp());
      final backgrounds = <Color>{};
      for (final label in ['Lihat Proyek', 'Tambah Proyek', 'Logout']) {
        final card = find.ancestor(
          of: find.text(label),
          matching: find.byType(ItemCard),
        );
        final surface = tester.widget<Material>(
          find.descendant(of: card, matching: find.byType(Material)).first,
        );
        backgrounds.add(surface.color!);
        expect(
          tester.widget<Text>(find.text(label)).style!.color,
          Colors.white,
        );
      }
      expect(backgrounds.length, 3);
    },
  );

  testWidgets('Small phone layout shows full identity and supports scrolling', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(320, 480);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(const MyApp());
    expect(find.text('Albert Timmothy Ariajaya'), findsOneWidget);
    await tester.ensureVisible(find.text('Logout'));
    await tester.tap(find.text('Logout'));
    await tester.pumpAndSettle();
    expect(find.text('Kamu telah menekan tombol Logout!'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
