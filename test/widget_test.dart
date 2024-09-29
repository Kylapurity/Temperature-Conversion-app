import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:calculate_project/main.dart'; // Update with your actual path

void main() {
  testWidgets('Temperature Converter Widget Test', (WidgetTester tester) async {
    // Build the app and trigger a frame.
    await tester.pumpWidget(const MaterialApp(home: TempConverter()));

    // Verify that the initial text is displayed
    expect(find.text('Select Conversion Type:'), findsOneWidget);
    expect(find.text('Enter temperature'), findsOneWidget);
    expect(find.text('Convert'), findsOneWidget);
  });
}

