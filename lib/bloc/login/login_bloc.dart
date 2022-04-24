import 'package:chat_app/extra/exports/exports.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    getOtp(GetOtp event, Emitter<LoginState> emit) async {
      await state.auth.verifyPhoneNumber(
        phoneNumber: event.phoneNumber,
        verificationCompleted: (PhoneAuthCredential _credential) {
          state.credential = _credential;
        },
        verificationFailed: (FirebaseAuthException exeption) {},
        codeSent: (String _verificationId, int? _token) {
          state.verificationId = _verificationId;
          state.token = _token;
        },
        codeAutoRetrievalTimeout: (String timeout) {
          ScaffoldMessenger.of(event.context).showSnackBar(
            const SnackBar(
              content: TextWidget(text: 'Otp time out'),
            ),
          );
        },
        timeout: const Duration(seconds: 70),
      );
      state.phone = event.phoneNumber;
    }

    verifyOtp(VerifyOtp event, Emitter<LoginState> emit) async {
      try {
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: state.verificationId ?? '',
          smsCode: event.otp,
        );
        // debugPrint(
        //   event.otp.toString(),
        // );
        UserCredential cred = await state.auth.signInWithCredential(
          credential,
        );
        state.user = cred.user;
        //debugPrint(cred.user?.isAnonymous.toString());
        // print(
        //   'id::::::${cred.user?.uid}',
        // );
        //Y2kpYOxIAsT9m2jutqbaYkLSMSD3
        //Y2kpYOxIAsT9m2jutqbaYkLSMSD3
      } on FirebaseAuthException catch (e) {
        state.loginException = e.message;
      }

      state.user != null
          ? {
              await LoginState.prefs?.setString(
                LoginState.phoneNumberKey,
                state.phone.toString(),
              ),
              Navigator.of(event.context).push(
                MaterialPageRoute(
                  builder: (ctx) => const ProfileSettingPage(),
                ),
              ),
              ////
              LoginState.userId = state.user?.uid,
              ////
            }
          : ScaffoldMessenger.of(event.context).showSnackBar(
              const SnackBar(
                content: TextWidget(
                  text: 'Incorrect Otp number',
                ),
              ),
            );
    }

    on<GetOtp>(getOtp);
    on<VerifyOtp>(verifyOtp);
  }
}
