import 'package:chat_app/bloc/login/login_bloc.dart';
import 'package:chat_app/extra/exports/exports.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: blueGrey,
      body: Padding(
        padding: const EdgeInsets.all(
          8.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              children: <Widget>[
                SizedBox(
                  height: size.shortestSide * 0.2,
                ),
                Column(
                  children: const <Widget>[
                    TextWidget(
                      text: 'Enter your phone number',
                      color: grey,
                      size: 20,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Center(
                        child: TextWidget(
                          text:
                              'We will sent an SMS message to your phone number',
                          color: grey,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.shortestSide * 0.2,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                  ),
                  child: Column(
                    children:const <Widget>[
                       DropDownWidget(),
                      LoginTextFieldWidget(
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.shortestSide * 0.3,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 30,
              ),
              child: NextbuttonWidget(
                navigation: () {
                  if (LoginState.formkey.currentState!.validate()) {
                    final String phoneNumber =
                        '${LoginState.countryCodeController.text}${LoginState.loginPhoneNumberController.text}';
                    BlocProvider.of<LoginBloc>(context).add(
                      GetOtp(
                        phoneNumber: phoneNumber,
                        context: context,
                      ),
                    );
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: ((context) => const OtpVarificationPage()),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
