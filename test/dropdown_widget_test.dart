import 'package:code_challenge/widget/dropdown_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:code_challenge/model/country.dart';
import 'package:code_challenge/model/states.dart'; // Adjust the import path as needed

void main() {
  group('DropdownWidget Tests', () {
    testWidgets('should render the widget with correct items', (WidgetTester tester) async {
      final countries = [
        Country(id: 1, name: 'Country 1'),
        Country(id: 2, name: 'Country 2'),
      ];

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: DropdownWidget<Country>(
            value: 1,
            items: countries,
            onChanged: (_) {},
          ),
        ),
      ));

      // Verify the widget is displayed with correct items
      expect(find.text('Country 1'), findsOneWidget);
      expect(find.text('Country 2'), findsNothing);  // Initially not in the dropdown button
    });

    testWidgets('should call onChanged when an item is selected', (WidgetTester tester) async {
      int? selectedValue;
      final countries = [
        Country(id: 1, name: 'Country 1'),
        Country(id: 2, name: 'Country 2'),
      ];

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: DropdownWidget<Country>(
            value: 1,
            items: countries,
            onChanged: (value) {
              selectedValue = value;
            },
          ),
        ),
      ));

      await tester.tap(find.byType(DropdownButton<int>));
      await tester.pumpAndSettle();

      // Verify dropdown items are rendered
      expect(find.text('Country 1').last, findsOneWidget);
      expect(find.text('Country 2'), findsOneWidget);

      // Select an item
      await tester.tap(find.text('Country 2').last);
      await tester.pumpAndSettle();

      // Verify the callback is called with the correct value
      expect(selectedValue, 2);
    });
  });
}
