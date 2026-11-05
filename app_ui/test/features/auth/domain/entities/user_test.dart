import 'package:flutter_test/flutter_test.dart';
import 'package:fekra_house/features/auth/domain/entities/user.dart';

void main() {
  const user = User(fullName: '  Tariq  Mansour ', title: 't', phone: 'p', organization: 'o');

  test('firstName is the first word of the full name', () {
    expect(user.firstName, 'Tariq');
  });

  test('initials take the first letter of the first two words', () {
    expect(user.initials, 'TM');
  });
}
