import 'package:chat_app/bloc/chat/chat_bloc.dart';
import 'package:chat_app/extra/exports/exports.dart';

class ChatMessageHoldingWidgets extends StatelessWidget {
  const ChatMessageHoldingWidgets({
    Key? key,
    required this.size,
    required this.phone,
    this.chatRoomId,
  }) : super(key: key);

  final Size size;
  final String phone;
  final String? chatRoomId;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height * 0.83,
      width: size.width,
      child: BlocConsumer<ChatBloc, ChatState>(
        listener: (context, state) {
          context.read<ChatBloc>().add(
                GetConversations(
                  phone: phone,
                  chatRoomId: chatRoomId,
                ),
              );
        },
        // buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          return ListView.separated(
            shrinkWrap: true,
            itemCount: state.conversation.length,
            reverse: true,
            itemBuilder: (context, index) {
              return Row(
                mainAxisAlignment: state.conversation[index].conversationKey !=
                        ChatState.userPhoneNumber
                    ? MainAxisAlignment.end
                    : MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      right: state.conversation[index].conversationKey !=
                              ChatState.userPhoneNumber
                          ? 9
                          : 0,
                      left: state.conversation[index].conversationKey ==
                              ChatState.userPhoneNumber
                          ? 0
                          : 9,
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      constraints: BoxConstraints(
                        maxWidth: size.width * 0.8,
                      ),
                      decoration: BoxDecoration(
                        color: state.conversation[index].conversationKey !=
                                ChatState.userPhoneNumber
                            ? darkGreen
                            : blueGrey,
                        borderRadius: BorderRadius.circular(
                          5,
                        ),
                      ),
                      child: Column(
                        children: [
                          TextWidget(
                            color: white,
                            align: TextAlign.left,
                            overflow: TextOverflow.visible,
                            size: 20,
                            text: state.conversation[index].textMessage,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              );
            },
            separatorBuilder: (context, index) {
              return const Divider(
                color: transp,
                height: 3,
              );
            },
          );
        },
      ),
    );
  }
}
