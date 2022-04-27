import 'package:chat_app/bloc/chat/chat_bloc.dart';
import 'package:chat_app/extra/exports/exports.dart';
import 'package:chat_app/extra/service/group_services.dart';
import 'package:chat_app/model/chats_model.dart';

class MainChatScreen extends StatelessWidget {
  const MainChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: GroupServices.getUserChatRooms(context: context),
      builder: (context, AsyncSnapshot<List<UserAllChatsModel>> snapshot) {
        //context.read<ChatBloc>().add(GetUserChatRooms(snapshotData: snapshot.data));
        return BlocListener<ChatBloc, ChatState>(
          listener: (context, state) {
            context.read<ChatBloc>().add(GetUserChatRooms());
          },
          child: BlocBuilder<ChatBloc, ChatState>(
            builder: (context, state) {
              return SizedBox(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: state.chatsDone.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: DpHoldingWidget(
                        encodedImg: state.chatsDone[index].conversationDp ?? '',
                        isGroup: state.chatsDone[index].isGroup,
                        color: grey,
                      ),
                      title: TextWidget(
                        text: state.chatsDone[index].conversationName,
                        color: white,
                      ),
                      //       subtitle: TextWidget(
                      //         text: FirebaseFirestore.instance
                      // .collection(state.chatsDone[index].chatRoomID)
                      // .get()
                      // .then((value) => value.docs
                      //     .map((e) => IndividualChatModel.fromJson(e.data()))
                      //     .toList().first.textMessage).toString(),
                      //         color: grey,
                      //       ),
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
                                isGroup: state.chatsDone[index].isGroup,
                                phone: state.chatsDone[index].phoneNumber,
                                chatRoomId: state.chatsDone[index].chatRoomID,
                              ),
                            );
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => IndividualChatScreen(
                              encodedDp:
                                  state.chatsDone[index].conversationDp ?? '',
                              isGroup: state.chatsDone[index].isGroup,
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
            },
          ),
        );
      },
    );
  }
}
