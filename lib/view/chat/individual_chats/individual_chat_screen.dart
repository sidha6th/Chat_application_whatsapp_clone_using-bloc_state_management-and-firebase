import 'package:chat_app/extra/exports/exports.dart';

class IndividualChatScreen extends StatelessWidget {
  const IndividualChatScreen({
    required this.encodedDp,
    required this.isChatRoomCreated,
    required this.phone,
    required this.name,
    required this.chatRoomId,
    required this.isGroup,
    this.isSent = true,
    Key? key,
  }) : super(key: key);
  final bool isSent;
  final String name;
  final String phone;
  final bool isChatRoomCreated;
  final String chatRoomId;
  final bool isGroup;
  final String encodedDp;

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
          encodedDp: encodedDp,
          isGroup: isGroup,
          titleName: name,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ChatMessageHoldingWidgets(
              isGroup: isGroup,
              isChatRoomCreated: isChatRoomCreated,
              chatRoomId: chatRoomId,
              size: size,
              phone: phone,
            ),
          ),
          BottomInputSection(
            isGroup: isGroup,
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
