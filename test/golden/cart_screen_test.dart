import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:menu_app/home_screen.dart';
import 'package:menu_app/main.dart';

void main() {
  testWidgets('empty', (tester) async {

    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.shopping_cart));
    await tester.pumpAndSettle();

    await expectLater(
      find.byType(HomeScreen),
      matchesGoldenFile('cart_empty.png'),
    );
    await tester.pumpAndSettle();
  });

  testWidgets('filled', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

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

    await expectLater(
      find.byType(HomeScreen),
      matchesGoldenFile('cart_filled.png'),
    );
  });
}