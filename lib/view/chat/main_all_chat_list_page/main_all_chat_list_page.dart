import 'package:chat_app/bloc/chat/chat_bloc.dart';
import 'package:chat_app/extra/exports/exports.dart';

class MainChatScreen extends StatelessWidget {
  const MainChatScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        return SizedBox(
          child: ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: state.chatData.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: const DpHoldingWidget(color: grey,),
                title: TextWidget(
                  text: state.chatData[index].messageRecieverName ??
                      state.chatData[index].messageRecieverphoneNumber,
                  color: white,
                ),
                subtitle: TextWidget(
                  text: state.chatData[state.chatData.length - 1].textMessage,
                  color: grey,
                ),
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
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => IndividualChatScreen(
                        name: state.chatData[index].messageRecieverName ??
                            state.chatData[index].messageRecieverphoneNumber,
                        phone: state.chatData[index].messageRecieverphoneNumber,
                      ),
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
