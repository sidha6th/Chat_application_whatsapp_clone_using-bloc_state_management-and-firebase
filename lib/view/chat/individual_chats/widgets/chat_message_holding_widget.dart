import 'package:chat_app/bloc/chat/chat_bloc.dart';
import 'package:chat_app/extra/exports/exports.dart';
import 'package:flutter/gestures.dart';

ScrollController scrollController = ScrollController();

class ChatMessageHoldingWidgets extends StatelessWidget {
  const ChatMessageHoldingWidgets({
    Key? key,
    required this.isChatRoomCreated,
    required this.size,
    required this.phone,
    required this.chatRoomId,
    required this.isGroup,
  }) : super(key: key);

  final Size size;
  final String phone;
  final String chatRoomId;
  final bool isChatRoomCreated;
  final bool isGroup;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height * 0.83,
      width: size.width,
      child: BlocConsumer<ChatBloc, ChatState>(
        listener: (context, state) {
          context.read<ChatBloc>().add(
                GetConversations(
                  isGroup: isGroup,
                  phone: phone,
                  chatRoomId: chatRoomId,
                ),
              );
        },
        builder: (context, state) {
          return ListView.separated(
            padding: const EdgeInsets.only(top: 20),
            controller: scrollController,
            itemCount: state.conversation.length,
            dragStartBehavior: DragStartBehavior.down,
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            itemBuilder: (context, index) {
              return Row(
                mainAxisAlignment:
                    state.conversation[index].messageSentNumber ==
                            ChatState.userPhoneNumber
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.start,
                children: [
                  state.conversation[index].messageSentNumber ==
                          ChatState.userPhoneNumber
                      ? SentMessageCard(
                          size: size,
                          isGroup: isGroup,
                          index: index,
                          state: state,
                        )
                      : ReceiveMessageCard(
                          size: size,
                          isGroup: isGroup,
                          index: index,
                          state: state,
                        ),
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
