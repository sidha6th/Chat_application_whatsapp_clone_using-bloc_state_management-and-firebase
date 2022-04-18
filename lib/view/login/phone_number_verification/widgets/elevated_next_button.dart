import 'package:chat_app/extra/exports/exports.dart';


class NextbuttonWidget extends StatelessWidget {
  const NextbuttonWidget({
    required this.navigation,
    Key? key,
  }) : super(key: key);
  final Function navigation;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        navigation();
      },
      child: const TextWidget(
        text: 'Next',
        color: black,
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          const Color.fromARGB(
            103,
            62,
            229,
            235,
          ),
        ),
      ),
    );
  }
}
