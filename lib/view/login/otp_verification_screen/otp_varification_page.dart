import 'package:chat_app/extra/exports/exports.dart';

class OtpVarificationPage extends StatelessWidget {
  const OtpVarificationPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        centerTitle: true,
        title: const TextWidget(
          text: 'Otp Verification',
          size: 20,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: OtpTextfieldWidget(),
          ),
          SizedBox(
            height: 20,
          ),
          TextWidget(
            text: 'If you didn\'t get any otp click here',
            color: grey,
          ),
        ],
      ),
    );
  }
}
