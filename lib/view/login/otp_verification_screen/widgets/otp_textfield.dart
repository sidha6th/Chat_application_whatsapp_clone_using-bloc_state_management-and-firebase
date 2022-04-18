import 'package:chat_app/bloc/login/login_bloc.dart';
import 'package:chat_app/extra/exports/exports.dart';
import 'package:pinput/pinput.dart';

class OtpTextfieldWidget extends StatelessWidget {
  const OtpTextfieldWidget({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal:10.0),
          child: Pinput(
            length: 6,
            defaultPinTheme:  PinTheme(
              textStyle: const TextStyle(fontSize: 40),
              width: size.width*10,
              decoration:const BoxDecoration(
                color: transp,
                border: Border(
                  bottom: BorderSide(
                    width: 3,
                    color: green,
                  ),
                ),
              ),
            ),
            focusedPinTheme:  PinTheme(
              width: size.width * 10,
              textStyle: const TextStyle(fontSize: 40),
              decoration: const BoxDecoration(
                color: transp,
                border: Border(
                  bottom: BorderSide(
                    width: 3,
                    color: green,
                  ),
                ),
              ),
            ),
            disabledPinTheme:  PinTheme(
              width: size.width * 10,
              textStyle: const TextStyle(fontSize: 40),
              decoration: const BoxDecoration(
                color: transp,
                border: Border(
                  bottom: BorderSide(
                    width: 3,
                    color: green,
                  ),
                ),
              ),
            ),
            controller: LoginState.otpTextController,
            pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
            showCursor: true,
            onCompleted: (pin) => BlocProvider.of<LoginBloc>(context).add(
              VerifyOtp(
                otp: LoginState.otpTextController.text,
                context: context,
              ),
            ),
          ),
        );
      },
    );
  }
}



// class OtpTextFormFieldWidget extends StatelessWidget {
//   const OtpTextFormFieldWidget({
//     required this.onchanged,
//     this.width = 20,
//     Key? key,
//   }) : super(key: key);
//   final double width;
//   final Function onchanged;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(
//         horizontal: width * 0.2,
//       ),
//       child: SizedBox(
//         width: width,
//         child: TextField(
//           onChanged: (String value) {
//             onchanged(value);
//           },
//           enableSuggestions: false,
//           cursorColor: green,
//           maxLength: 1,
//           maxLines: 1,
//           textAlign: TextAlign.center,
//           textInputAction: TextInputAction.next,
//           cursorHeight: 25,
//           style: const TextStyle(color: grey),
//           keyboardType: TextInputType.number,
//           decoration: const InputDecoration(
//             counterText: '',
//             enabledBorder: UnderlineInputBorder(
//               borderSide: BorderSide(
//                 color: green,
//                 width: 2,
//               ),
//             ),
//             focusedBorder: UnderlineInputBorder(
//               borderSide: BorderSide(
//                 color: green,
//                 width: 2,
//               ),
//             ),
//             border: UnderlineInputBorder(
//               borderSide: BorderSide(
//                 color: green,
//                 width: 2,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
