import 'package:equatable/equatable.dart';

/// A country the user can pick for their phone number, with its dialing rules.
class Country extends Equatable {
  final String isoCode; // ISO 3166-1 alpha-2, e.g. "EG"
  final String name;
  final String dialCode; // e.g. "+20"
  final int minDigits; // national number length, without the leading 0
  final int maxDigits;
  final String example; // shown as the field hint

  const Country({
    required this.isoCode,
    required this.name,
    required this.dialCode,
    required this.minDigits,
    required this.maxDigits,
    required this.example,
  });

  /// Flag emoji built from the ISO code (regional indicator symbols).
  String get flag => String.fromCharCodes(isoCode.toUpperCase().codeUnits.map((c) => 0x1F1E6 + c - 0x41));

  static const egypt =
      Country(isoCode: 'EG', name: 'Egypt', dialCode: '+20', minDigits: 10, maxDigits: 10, example: '10 1234 5678');

  /// Default first, then the rest of the region, then common international ones.
  static const all = [
    egypt,
    Country(isoCode: 'SA', name: 'Saudi Arabia', dialCode: '+966', minDigits: 9, maxDigits: 9, example: '50 123 4567'),
    Country(isoCode: 'AE', name: 'United Arab Emirates', dialCode: '+971', minDigits: 9, maxDigits: 9, example: '50 123 4567'),
    Country(isoCode: 'KW', name: 'Kuwait', dialCode: '+965', minDigits: 8, maxDigits: 8, example: '5012 3456'),
    Country(isoCode: 'QA', name: 'Qatar', dialCode: '+974', minDigits: 8, maxDigits: 8, example: '3312 3456'),
    Country(isoCode: 'BH', name: 'Bahrain', dialCode: '+973', minDigits: 8, maxDigits: 8, example: '3600 1234'),
    Country(isoCode: 'OM', name: 'Oman', dialCode: '+968', minDigits: 8, maxDigits: 8, example: '9212 3456'),
    Country(isoCode: 'JO', name: 'Jordan', dialCode: '+962', minDigits: 9, maxDigits: 9, example: '7 9012 3456'),
    Country(isoCode: 'LB', name: 'Lebanon', dialCode: '+961', minDigits: 7, maxDigits: 8, example: '71 123 456'),
    Country(isoCode: 'PS', name: 'Palestine', dialCode: '+970', minDigits: 9, maxDigits: 9, example: '59 912 3456'),
    Country(isoCode: 'SY', name: 'Syria', dialCode: '+963', minDigits: 9, maxDigits: 9, example: '944 567 890'),
    Country(isoCode: 'IQ', name: 'Iraq', dialCode: '+964', minDigits: 10, maxDigits: 10, example: '791 234 5678'),
    Country(isoCode: 'YE', name: 'Yemen', dialCode: '+967', minDigits: 9, maxDigits: 9, example: '712 345 678'),
    Country(isoCode: 'SD', name: 'Sudan', dialCode: '+249', minDigits: 9, maxDigits: 9, example: '91 123 1234'),
    Country(isoCode: 'LY', name: 'Libya', dialCode: '+218', minDigits: 9, maxDigits: 9, example: '91 234 5678'),
    Country(isoCode: 'TN', name: 'Tunisia', dialCode: '+216', minDigits: 8, maxDigits: 8, example: '20 123 456'),
    Country(isoCode: 'DZ', name: 'Algeria', dialCode: '+213', minDigits: 9, maxDigits: 9, example: '551 23 45 67'),
    Country(isoCode: 'MA', name: 'Morocco', dialCode: '+212', minDigits: 9, maxDigits: 9, example: '650 123 456'),
    Country(isoCode: 'TR', name: 'Türkiye', dialCode: '+90', minDigits: 10, maxDigits: 10, example: '501 234 5678'),
    Country(isoCode: 'GB', name: 'United Kingdom', dialCode: '+44', minDigits: 10, maxDigits: 10, example: '7400 123456'),
    Country(isoCode: 'US', name: 'United States', dialCode: '+1', minDigits: 10, maxDigits: 10, example: '201 555 0123'),
  ];

  @override
  List<Object?> get props => [isoCode, dialCode];
}
