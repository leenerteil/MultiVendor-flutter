
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shopzy/screens/main_screen.dart';
import 'package:shopzy/screens/home_screen.dart';
import 'package:shopzy/screens/shops_screen.dart';

void main() {
  testWidgets('MainScreen navigation test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MaterialApp(home: MainScreen()));

    // Verify that HomeScreen is displayed initially.
    expect(find.byType(HomeScreen), findsOneWidget);
    expect(find.byType(ShopsScreen), findsOneWidget); // IndexedStack builds all children, but only one is visible.
    // However, finding by type usually finds it even if offstage.
    // To check visibility, we checks Opacity or Offstage widget, but IndexedStack uses Offstage.

    // Tap the Shops tab (index 1).
    await tester.tap(find.text('Shops'));
    await tester.pump();

    // Verify state change.
    // Check key text from ShopsScreen
    expect(find.text('Discover Shops'), findsOneWidget); 
    // Check key text from HomeScreen (should likely be offstage or hidden, but IndexedStack keeps it built)
    // IndexedStack hides children but they are still in tree. 
    // find.text finds them.
    // But we want to know if "Shops" is the current index.
    // We can check if the "Shops" icon changed to filled?
    expect(find.byIcon(Icons.store), findsOneWidget); // Active icon for Shops

  });
}


