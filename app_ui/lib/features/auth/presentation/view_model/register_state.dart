import 'package:equatable/equatable.dart';

enum RegisterStatus { initial, submitting, success, failure }

class RegisterState extends Equatable {
  final RegisterStatus status;
  final String? errorMessage;

  const RegisterState({this.status = RegisterStatus.initial, this.errorMessage});

  bool get isSubmitting => status == RegisterStatus.submitting;

  RegisterState copyWith({RegisterStatus? status, String? errorMessage}) =>
      RegisterState(status: status ?? this.status, errorMessage: errorMessage);

  @override
  List<Object?> get props => [status, errorMessage];
}
