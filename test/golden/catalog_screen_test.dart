import 'package:flutter_test/flutter_test.dart';
import 'package:menu_app/home_screen.dart';
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
    await tester.pumpAndSettle();

    await expectLater(
      find.byType(HomeScreen),
      matchesGoldenFile('catalog_loaded.png'),
    );
  });
}
