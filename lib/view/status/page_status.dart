import 'package:chat_app/extra/exports/exports.dart';

class StatusPage extends StatelessWidget {
  const StatusPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          leading: SizedBox(
            width: 45,
            height: 45,
            child: Stack(
              children: const [
                DpHoldingWidget(
                  encodedImg: '',
                  color: grey,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: CircleAvatar(
                    backgroundColor: darkGreen,
                    child: Icon(
                      Icons.add,
                      color: black,
                      size: 15,
                    ),
                    radius: 10,
                  ),
                ),
              ],
            ),
          ),
          title: const TextWidget(
            text: 'My Status',
            color: white,
          ),
          subtitle: const TextWidget(
            text: 'Tap to add status update',
            color: grey,
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: 15,
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemBuilder: (context, index) => const ListTile(
              leading: DpHoldingWidget(
                color: grey,
                encodedImg: '',
              ),
              title: TextWidget(
                text: 'Title',
                weight: FontWeight.bold,
                size: 20,
                color: grey,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
