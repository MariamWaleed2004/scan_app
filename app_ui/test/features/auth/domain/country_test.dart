import 'package:fekra_house/features/auth/domain/entities/country.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Egypt is the default and first in the list', () {
    expect(Country.all.first, Country.egypt);
    expect(Country.egypt.dialCode, '+20');
  });

  test('flag is built from the ISO code', () {
    expect(Country.egypt.flag, '🇪🇬');
  });

  test('every country has a unique ISO code and a valid digit range', () {
    expect(Country.all.map((c) => c.isoCode).toSet().length, Country.all.length);
    for (final c in Country.all) {
      expect(c.minDigits <= c.maxDigits, isTrue, reason: c.name);
      expect(c.dialCode.startsWith('+'), isTrue, reason: c.name);
    }
  });
}
