part of 'splash_bloc.dart';

class SplashState {
  final bool isUSerLoggedIn;
  final bool checking;
  SplashState({
    required this.isUSerLoggedIn,
    required this.checking,
  });
}

class SplashInitial extends SplashState {
  SplashInitial({
    required bool isUSerLoggedIn,
  }) : super(
          isUSerLoggedIn: isUSerLoggedIn,
          checking: true,
        );
}
