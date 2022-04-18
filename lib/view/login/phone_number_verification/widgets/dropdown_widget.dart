import 'package:chat_app/bloc/login/login_bloc.dart';
import 'package:chat_app/extra/exports/exports.dart';

DropdownMenuItem<String> selectcontry(String contry) => DropdownMenuItem(
      value: contry,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextWidget(
            text: contry,
            color: grey,
          ),
        ],
      ),
    );

class DropDownWidget extends StatelessWidget {
  const DropDownWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setstate) {
        return DropdownButton<String>(
          underline: Container(
            height: 2,
            color: green,
          ),
          isExpanded: true,
          value: LoginState.value ?? LoginState.country[0],
          items: LoginState.country.map(selectcontry).toList(),
          onChanged: (String? data) {
            for (var i = 0; i < LoginState.country.length; i++) {
              if (LoginState.country[i] == data) {
                LoginState.index = i;
              }
            }
            (LoginState.index == null || LoginState.index == 0)
                ? LoginState.countryCodeController.text = ' '
                : LoginState.countryCodeController.text =
                    LoginState.contryCode[LoginState.index!];
            setstate(
              () {
                LoginState.value = data;
              },
            );
          },
        );
      },
    );
  }
}
