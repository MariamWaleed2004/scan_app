import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String fullName;
  final String title;
  final String phone;
  final String organization;

  const User({
    required this.fullName,
    required this.title,
    required this.phone,
    required this.organization,
  });

  String get firstName => fullName.trim().split(' ').first;

  String get initials {
    final parts = fullName.trim().split(RegExp(r'\s+')).where((p) => p.isNotEmpty);
    return parts.take(2).map((p) => p[0].toUpperCase()).join();
  }

  @override
  List<Object?> get props => [fullName, title, phone, organization];
}
