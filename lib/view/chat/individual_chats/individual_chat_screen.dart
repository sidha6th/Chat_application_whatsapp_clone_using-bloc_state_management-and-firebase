import 'package:chat_app/extra/exports/exports.dart';

class IndividualChatScreen extends StatelessWidget {
  const IndividualChatScreen({
    this.isSent = true,
    required this.phone,
    required this.name,
    Key? key,
  }) : super(key: key);
  final bool isSent;
  final String name;
  final String phone;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: homeColor,
      appBar: PreferredSize(
        preferredSize: Size(
          size.width,
          50,
        ),
        child: IndividualChatAppBarWidget(
          titleName: name,
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          ChatMessageHoldingWidgets(
            size: size,
            phone: phone,
          ),
          BottomInputSection(
            name: name,
            phone: phone,
            size: size,
          ),
        ],
      ),
    );
  }
}
