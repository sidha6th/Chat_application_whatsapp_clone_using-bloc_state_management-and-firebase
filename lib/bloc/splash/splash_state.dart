part of 'splash_bloc.dart';

class SplashState {
  final bool isUSerLoggedIn;
  SplashState({
    required this.isUSerLoggedIn,
  });
}

class SplashInitial extends SplashState {
  SplashInitial({
    required bool isUSerLoggedIn,
  }) : super(
          isUSerLoggedIn: isUSerLoggedIn,
        );
}
