import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.fullName,
    required super.title,
    required super.phone,
    required super.organization,
  });

  factory UserModel.fromJson(Map<String, dynamic> j) => UserModel(
        fullName: j['full_name'] as String,
        title: j['title'] as String,
        phone: j['phone'] as String,
        organization: j['organization'] as String,
      );

  Map<String, dynamic> toJson() =>
      {'full_name': fullName, 'title': title, 'phone': phone, 'organization': organization};
}
