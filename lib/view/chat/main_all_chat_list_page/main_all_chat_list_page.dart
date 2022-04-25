import 'package:chat_app/bloc/chat/chat_bloc.dart';
import 'package:chat_app/extra/exports/exports.dart';
import 'package:chat_app/extra/service/group_services.dart';

class MainChatScreen extends StatelessWidget {
  const MainChatScreen({Key? key}) : super(key: key);

  // @override
  // void initState() {
  //   super.initState();
  //   context.read<ChatBloc>().add(
  //         GetUserChatRooms(),
  //       );
  // }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
        stream: GroupServices.getUserChatRooms(),
        builder: (context,snapshot) {
          context.read<ChatBloc>().add(GetUserChatRooms());
          return BlocBuilder<ChatBloc, ChatState>(builder: (context, state) {
            return SizedBox(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: state.chatsDone.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const DpHoldingWidget(
                      color: grey,
                    ),
                    title: TextWidget(
                      text: state.chatsDone[index].conversationName,
                      color: white,
                    ),
                    // subtitle: TextWidget(
                    //   text: state.chatData[state.chatData.length - 1].textMessage,
                    //   color: grey,
                    // ),
                    trailing: SizedBox(
                      width: 50,
                      height: 50,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: const [
                          TextWidget(
                            text: '2.23 pm',
                            color: green,
                            size: 13,
                          ),
                          CircleAvatar(
                            child: TextWidget(
                              text: '13',
                              size: 10,
                              color: black,
                              weight: FontWeight.bold,
                            ),
                            radius: 13,
                            backgroundColor: Colors.green,
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      context.read<ChatBloc>().add(
                            GetConversations(
                              phone: state.chatsDone[index].phoneNumber,
                              chatRoomId: state.chatsDone[index].chatRoomID,
                            ),
                          );
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => IndividualChatScreen(
                            isChatRoomCreated: true,
                            chatRoomId: state.chatsDone[index].chatRoomID,
                            name: state.chatsDone[index].conversationName,
                            phone: state.chatsDone[index].phoneNumber,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            );
          });
        });
  }
}
