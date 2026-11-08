import 'package:equatable/equatable.dart';
import 'package:fekra_house/features/auth/domain/entities/user.dart';

enum ProfileStatus { loading, success, failure }

class ProfileState extends Equatable {
  final ProfileStatus status;
  final User? user;
  final String? errorMessage;

  const ProfileState({this.status = ProfileStatus.loading, this.user, this.errorMessage});

  ProfileState copyWith({ProfileStatus? status, User? user, String? errorMessage}) => ProfileState(
        status: status ?? this.status,
        user: user ?? this.user,
        errorMessage: errorMessage,
      );

  @override
  List<Object?> get props => [status, user, errorMessage];
}
