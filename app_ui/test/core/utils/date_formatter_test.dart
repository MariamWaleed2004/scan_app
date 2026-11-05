import 'package:flutter_test/flutter_test.dart';
import 'package:fekra_house/core/utils/date_formatter.dart';

void main() {
  final now = DateTime(2026, 11, 5, 18);

  test('day labels today, yesterday and older dates', () {
    expect(DateFormatter.day(DateTime(2026, 11, 5, 0, 1), now: now), 'Today');
    expect(DateFormatter.day(DateTime(2026, 11, 4, 23, 59), now: now), 'Yesterday');
    expect(DateFormatter.day(DateTime(2025, 5, 12), now: now), 'May 12, 2025');
  });

  test('time uses a 12-hour clock', () {
    expect(DateFormatter.time(DateTime(2026, 1, 1, 0, 5)), '12:05 AM');
    expect(DateFormatter.time(DateTime(2026, 1, 1, 12, 0)), '12:00 PM');
    expect(DateFormatter.time(DateTime(2026, 1, 1, 16, 45)), '4:45 PM');
  });

  test('relative adds the time only for today and yesterday', () {
    expect(DateFormatter.relative(DateTime(2026, 11, 5, 11, 20), now: now), 'Today, 11:20 AM');
    expect(DateFormatter.relative(DateTime(2025, 5, 12, 9), now: now), 'May 12, 2025');
  });
}
