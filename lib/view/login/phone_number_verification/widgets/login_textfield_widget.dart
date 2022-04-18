import 'package:chat_app/bloc/login/login_bloc.dart';
import 'package:chat_app/extra/exports/exports.dart';

class LoginTextFieldWidget extends StatelessWidget {
  const LoginTextFieldWidget({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Form(
      key: LoginState.formkey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 70,
            child: TextFormFieldWidget(
              errorValidator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'please select your country';
                } else if (!LoginState.contryCode.contains(value)) {
                  return 'Enter valid contry code';
                } else {
                  null;
                }
              },
              textEditingController: LoginState.countryCodeController,
            ),
          ),
          SizedBox(
            width: 150,
            child: TextFormFieldWidget(
              errorValidator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'This field cannot be empty';
                } else if (value.length <10) {
                  return 'Enter valid phone number';
                } else {
                  return null;
                }
              },
              textEditingController: LoginState.loginPhoneNumberController,
            ),
          ),
        ],
      ),
    );
  }
}
