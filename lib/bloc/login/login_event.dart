part of 'login_bloc.dart';

abstract class LoginEvent {}

class GetOtp extends LoginEvent {
  final String phoneNumber;
  final BuildContext context;
  GetOtp({
    required this.phoneNumber,
    required this.context,
  });
}

class VerifyOtp extends LoginEvent {
  final String otp;
  final BuildContext context;
  VerifyOtp({
    required this.context,
    required this.otp,
  });
}

