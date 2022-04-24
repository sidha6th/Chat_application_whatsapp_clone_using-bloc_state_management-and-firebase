import 'package:bloc/bloc.dart';
import 'package:chat_app/bloc/login/login_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc()
      : super(SplashState(
          isUSerLoggedIn: false,
          checking: true,
        )) {
    on<CheckUserLoggedInOrNot>((event, emit) async {
      LoginState.prefs = await SharedPreferences.getInstance();
      bool? islogined = LoginState.prefs?.getBool(
        LoginState.isLoginedKey,
      );
      emit(
        SplashState(
          checking: false,
          isUSerLoggedIn:
              (islogined == null || islogined == false) ? false : true,
        ),
      );
    });
  }
}
