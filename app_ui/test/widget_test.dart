import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app_ui/main.dart';

void main() {
  testWidgets('Logo scales its three bars', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(body: Logo(size: 2)),
    ));

    final bars = find.descendant(
      of: find.byType(Logo),
      matching: find.byType(Container),
    );
    expect(bars, findsNWidgets(3));
    expect(tester.getSize(bars.at(0)), const Size(24, 144));
    expect(tester.getSize(bars.at(1)), const Size(24, 100));
    expect(tester.getSize(bars.at(2)), const Size(24, 80));
    expect(tester.takeException(), isNull);
  });
}
