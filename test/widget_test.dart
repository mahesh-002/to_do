import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:to_do/main.dart';

void main() {
  testWidgets('Add a task and verify it appears in the list', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    // Find the first TextField (task input) and enter a task
    final textFields = find.byType(TextField);
    await tester.enterText(textFields.first, 'Buy groceries');

    // Tap the 'Add Task' button
    await tester.tap(find.text('Add Task'));
    await tester.pump();

    // Verify the task appears
    expect(find.text('Buy groceries'), findsOneWidget);
  });

  testWidgets('Delete a task and verify it is removed', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    await tester.enterText(find.byType(TextField).first, 'Do laundry');
    await tester.tap(find.text('Add Task'));
    await tester.pump();

    expect(find.text('Do laundry'), findsOneWidget);

    // Tap the delete icon
    final deleteIcon = find.byIcon(Icons.delete);
    await tester.tap(deleteIcon.first);
    await tester.pump();

    // Verify it's removed
    expect(find.text('Do laundry'), findsNothing);
  });

  testWidgets('Mark a task as completed', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    await tester.enterText(find.byType(TextField).first, 'Walk the dog');
    await tester.tap(find.text('Add Task'));
    await tester.pump();

    // Tap the check icon
    final checkIcon = find.byIcon(Icons.check);
    await tester.tap(checkIcon.first);
    await tester.pump();

    // Check the text has the checkmark
    expect(find.textContaining('✔️'), findsOneWidget);
  });
}