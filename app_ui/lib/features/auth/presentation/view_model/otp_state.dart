import 'package:equatable/equatable.dart';

enum OtpStatus { initial, verifying, verified, failure }

class OtpState extends Equatable {
  /// Phone the code was sent to; null while loading.
  final String? phone;
  final OtpStatus status;
  final String? errorMessage;

  const OtpState({this.phone, this.status = OtpStatus.initial, this.errorMessage});

  bool get isVerifying => status == OtpStatus.verifying;

  OtpState copyWith({String? phone, OtpStatus? status, String? errorMessage}) => OtpState(
        phone: phone ?? this.phone,
        status: status ?? this.status,
        errorMessage: errorMessage,
      );

  @override
  List<Object?> get props => [phone, status, errorMessage];
}
