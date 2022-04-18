import 'package:chat_app/extra/exports/exports.dart';

class LodingWidget extends StatelessWidget {
  const LodingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          color: white,
          backgroundColor: transp,
        ),
      ),
    );
  }
}
