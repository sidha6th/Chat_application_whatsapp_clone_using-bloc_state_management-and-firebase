import 'package:chat_app/extra/exports/exports.dart';

class IndividualChatScreen extends StatelessWidget {
  const IndividualChatScreen({
    required this.isChatRoomCreated,
    required this.phone,
    required this.name,
    this.chatRoomId,
    this.isSent = true,
    Key? key,
  }) : super(key: key);
  final bool isSent;
  final String name;
  final String phone;
  final bool isChatRoomCreated;
  final String? chatRoomId;

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
            chatRoomId: chatRoomId,
            size: size,
            phone: phone,
          ),
          BottomInputSection(
            chatRoomId: chatRoomId,
            isChatRoomCreated: isChatRoomCreated,
            name: name,
            phone: phone,
            size: size,
          ),
        ],
      ),
    );
  }
}
