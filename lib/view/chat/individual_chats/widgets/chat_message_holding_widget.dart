import 'package:chat_app/bloc/chat/chat_bloc.dart';
import 'package:chat_app/extra/exports/exports.dart';

class ChatMessageHoldingWidgets extends StatefulWidget {
  const ChatMessageHoldingWidgets({
    Key? key,
    required this.size,
    required this.phone,
  }) : super(key: key);

  final Size size;
  final String phone;

  @override
  State<ChatMessageHoldingWidgets> createState() =>
      _ChatMessageHoldingWidgetsState();
}

class _ChatMessageHoldingWidgetsState extends State<ChatMessageHoldingWidgets> {
  @override
  void initState() {
    context.read<ChatBloc>().add(
          GetConversations(phone: widget.phone),
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.size.height * 0.83,
      width: widget.size.width,
      child: BlocConsumer<ChatBloc, ChatState>(
        listener: (context, state) {
          context.read<ChatBloc>().add(
                GetConversations(phone: widget.phone),
              );
        },
        builder: (context, state) {
          return ListView.separated(
            shrinkWrap: true,
            itemCount: state.chatData.length,
            reverse: true,
            itemBuilder: (context, index) {
              return Row(
                mainAxisAlignment: state.chatData[index].isSent
                    ? MainAxisAlignment.end
                    : MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      right: state.chatData[index].isSent==false ? 9 : 0,
                      left: state.chatData[index].isSent ? 0 : 9,
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      constraints: BoxConstraints(
                        maxWidth: widget.size.width * 0.8,
                      ),
                      decoration: BoxDecoration(
                        color:
                            state.chatData[index].isSent ? darkGreen : blueGrey,
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
                            text: state.chatData[index].textMessage,
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
