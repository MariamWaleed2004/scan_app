import '../../domain/entities/user.dart';

/// API / storage representation of a user. JSON field names live here only.
class UserModel {
  final String fullName;
  final String title;
  final String phone;
  final String organization;

  const UserModel({
    required this.fullName,
    required this.title,
    required this.phone,
    required this.organization,
  });

  factory UserModel.fromJson(Map<String, dynamic> j) => UserModel(
        fullName: j['full_name'] as String,
        title: j['title'] as String,
        phone: j['phone'] as String,
        organization: j['organization'] as String,
      );

  Map<String, dynamic> toJson() =>
      {'full_name': fullName, 'title': title, 'phone': phone, 'organization': organization};

  User toEntity() => User(fullName: fullName, title: title, phone: phone, organization: organization);
}
