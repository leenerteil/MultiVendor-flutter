import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shopzy/screens/categories_screen.dart';

void main() {
  testWidgets('CategoriesScreen renders correctly without error', (WidgetTester tester) async {
    // Wrap in MaterialApp/Scaffold because it might need Material/Directionality
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: IndexedStack(
          index: 0,
          children: [CategoriesScreen()],
        ),
      ),
    ));

    // Allow animations to settle (Slivers, Hero)
    await tester.pumpAndSettle();

    // Check for "Categories" title
    expect(find.text('Categories'), findsOneWidget);

    // Check for a category name
    expect(find.text('Cosmetics'), findsOneWidget);
    expect(find.text('Clothing'), findsOneWidget);

    // Check for tab bar items
    expect(find.text('All Categories'), findsOneWidget);

    // OPTIONAL: Check for scroll
    await tester.drag(find.byType(CustomScrollView), const Offset(0, -300));
    await tester.pumpAndSettle();
  });
}
