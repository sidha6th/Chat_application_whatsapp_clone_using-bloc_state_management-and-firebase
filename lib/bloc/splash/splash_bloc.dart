import 'package:bloc/bloc.dart';
import 'package:chat_app/bloc/login/login_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial(isUSerLoggedIn: false)) {
    on<CheckUserLoggedInOrNot>((event, emit) async {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? userPhoneNumber = pref.getString(
        LoginState.phoneNumberKey,
      );
      emit(
        SplashState(
          isUSerLoggedIn: userPhoneNumber == null ? false : true,
        ),
      );
    });
  }
}
