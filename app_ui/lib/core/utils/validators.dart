/// Format-only input checks shared by forms. Each returns an error message,
/// or null when the value is valid (matches `TextFormField.validator`).
class Validators {
  Validators._();

  static String? notEmpty(String? value, {String field = 'This field'}) =>
      (value == null || value.trim().isEmpty) ? '$field is required' : null;

  /// National number without the country code, e.g. "10 1234 5678".
  /// Spaces / dashes and one leading 0 (local trunk prefix, e.g. "010...") are ignored.
  static String? phone(String? value, {int minDigits = 8, int maxDigits = 10}) {
    var digits = (value ?? '').replaceAll(RegExp(r'[\s-]'), '');
    if (digits.isEmpty) return 'Phone number is required';
    if (digits.startsWith('0')) digits = digits.substring(1);
    final ok = RegExp(r'^\d+$').hasMatch(digits) && digits.length >= minDigits && digits.length <= maxDigits;
    return ok ? null : 'Enter a valid phone number';
  }

  static String? password(String? value, {int minLength = 8}) {
    if (value == null || value.isEmpty) return 'Password is required';
    if (value.length < minLength) return 'Password must be at least $minLength characters';
    return null;
  }
}