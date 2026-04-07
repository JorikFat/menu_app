import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:menu_app/screens/home_screen.dart';
import 'package:menu_app/main.dart';

void main() {
  testWidgets('loading', (tester) async {
    await tester.pumpWidget(const MyApp());

    await expectLater(
      find.byType(HomeScreen),
      matchesGoldenFile('catalog_loading.png'),
    );
    await tester.pumpAndSettle();
  });  
  
  testWidgets('loaded', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle(const Duration(seconds: 2));//FIXME: remove specific duration

    await expectLater(
      find.byType(HomeScreen),
      matchesGoldenFile('catalog_loaded.png'),
    );
  });

  testWidgets('filled', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle(const Duration(seconds: 2));//FIXME: remove specific duration

    await tester.tap(find.text("Бургер"));

    final third = find.text("Картошка фри");
    await tester.tap(third);
    await tester.tap(third);
    
    final fourth = find.text("Кола");
    await tester.tap(fourth);
    await tester.tap(fourth);
    await tester.tap(fourth);

    final fifth = find.text("Фанта");
    await tester.tap(fifth);
    await tester.tap(fifth);
    await tester.tap(fifth);
    await tester.tap(fifth);
    await tester.pumpAndSettle();

    await expectLater(
      find.byType(HomeScreen),
      matchesGoldenFile('catalog_filled.png'),
    );
  });

    testWidgets('reopen page', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle(const Duration(seconds: 2));//FIXME: remove specific duration

    await tester.tap(find.text("Бургер"));

    final third = find.text("Картошка фри");
    await tester.tap(third);
    await tester.tap(third);
    
    final fourth = find.text("Кола");
    await tester.tap(fourth);
    await tester.tap(fourth);
    await tester.tap(fourth);

    final fifth = find.text("Фанта");
    await tester.tap(fifth);
    await tester.tap(fifth);
    await tester.tap(fifth);
    await tester.tap(fifth);
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.shopping_cart));
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.list_alt));
    await tester.pumpAndSettle();

    await expectLater(
      find.byType(HomeScreen),
      matchesGoldenFile('catalog_filled.png'),
    );
  });
}
