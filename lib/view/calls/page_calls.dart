import 'package:chat_app/extra/exports/exports.dart';

class MainCallsScreen extends StatelessWidget {
  const MainCallsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        return ListTile(
          leading: const DpHoldingWidget(
            encodedImg: '',
            color: grey,
          ),
          title: const TextWidget(
            text: 'Name of the person',
            color: grey,
            size: 17,
          ),
          subtitle: SizedBox(
            width: 80,
            child: Row(
              children: [
                Transform.rotate(
                  angle: 150,
                  child: const Icon(
                    Icons.arrow_back,
                    color: green,
                    size: 15,
                  ),
                ),
                const TextWidget(
                  text: 'Today 5:28 pm',
                  color: grey,
                  size: 12,
                ),
              ],
            ),
          ),
          trailing: const Icon(
            Icons.phone,
            color: green,
            size: 20,
          ),
        );
      },
    );
  }
}
