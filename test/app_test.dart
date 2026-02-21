import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:menu_app/features/catalog/list/catalog_widget.dart';
import 'package:menu_app/main.dart';

void main() {
  group('initial', () {
    
    testWidgets('catalog', (tester) async {
      await tester.pumpWidget(const MyApp());

      expect(find.byType(CatalogLoadingWidget), findsOneWidget);
      expect(find.byType(CatalogListWidget), findsNothing);

      await tester.pumpAndSettle();

      expect(find.byType(CatalogLoadingWidget), findsNothing);
      expect(find.byType(CatalogListWidget), findsOneWidget);
    });

    testWidgets('cart', (tester) async {
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.shopping_cart));
      await tester.pumpAndSettle();

      expect(find.text("Корзина пуста"), findsOneWidget);
    });
  });
}
