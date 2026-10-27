import 'package:flutter_test/flutter_test.dart';
import 'package:fekra_house/core/utils/validators.dart';

void main() {
  group('notEmpty', () {
    test('rejects empty and whitespace-only values', () {
      expect(Validators.notEmpty(null, field: 'Name'), 'Name is required');
      expect(Validators.notEmpty('   ', field: 'Name'), 'Name is required');
    });

    test('accepts text', () => expect(Validators.notEmpty('Tariq'), isNull));
  });

  group('phone', () {
    test('accepts 8–10 digits with spaces or dashes', () {
      expect(Validators.phone('50 123 4567'), isNull);
      expect(Validators.phone('50-123-4567'), isNull);
    });

    test('rejects empty, letters, too short or too long', () {
      expect(Validators.phone(''), 'Phone number is required');
      expect(Validators.phone('50 12A 4567'), 'Enter a valid phone number');
      expect(Validators.phone('1234567'), 'Enter a valid phone number');
      expect(Validators.phone('12345678901'), 'Enter a valid phone number');
    });
  });

  group('phone with country rules (Egypt: 10 digits)', () {
    String? egypt(String v) => Validators.phone(v, minDigits: 10, maxDigits: 10);

    test('accepts the national number with or without the leading 0', () {
      expect(egypt('10 1234 5678'), isNull);
      expect(egypt('010 1234 5678'), isNull);
    });

    test('rejects a number with the wrong length', () {
      expect(egypt('10 1234 567'), 'Enter a valid phone number');
      expect(egypt('10 1234 56789'), 'Enter a valid phone number');
    });
  });

  group('password', () {
    test('requires a value of at least 8 characters', () {
      expect(Validators.password(''), 'Password is required');
      expect(Validators.password('short'), 'Password must be at least 8 characters');
      expect(Validators.password('long-enough'), isNull);
    });
  });
}