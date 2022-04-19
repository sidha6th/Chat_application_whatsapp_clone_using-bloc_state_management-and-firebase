import 'package:chat_app/bloc/login/login_bloc.dart';
import 'package:chat_app/extra/exports/exports.dart';
import 'package:chat_app/model/chats_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatState(chatData: [])) {
    sentMessage(SentMessage event, Emitter<ChatState> emit) async {
      if (ChatState.userPhoneNumber == null) {
        LoginState.prefs = await SharedPreferences.getInstance();
        ChatState.userPhoneNumber = LoginState.prefs?.getString(
          LoginState.phoneNumberKey,
        );
      }
      ChatDetailsModel data = ChatDetailsModel(
        messageRecieverphoneNumber: event.phone,
        isSent: true,
        textMessage: event.message,
        messageRecieverName: event.name,
        time: event.time,
      );
      ChatState.textMsg.value = '';
      DatabaseReference reference = FirebaseDatabase.instance.ref();
      if (ChatState.userPhoneNumber != null) {
        await reference
            .child(
              //event.phone.trim(),
              ChatState.userPhoneNumber!.trim(),
            )
            .child(
              event.phone.trim(),
              //ChatState.userPhoneNumber!.trim(),
            )
            .push()
            .set(
              data.toJson(),
            );
        state.chatData.add(
          data,
        );
      }
      if (ChatState.userPhoneNumber != null) {
        DatabaseEvent dEvent =
            await reference.child(ChatState.userPhoneNumber!).once();
        print(dEvent.previousChildKey);
      }
      emit(
        ChatState(
          chatData: state.chatData,
        ),
      );
    }

    getConversations(GetConversations event, Emitter<ChatState> emit) {
      DatabaseReference data = FirebaseDatabase.instance.ref();
      // data
      //     .child(
      //       event.phone,
      //     )
      //     .onValue
      //     .listen(
      //   (events) {
      //     events.snapshot.value;
      //   },
      // );
      // FirebaseDatabase.instance
      //     .ref()
      //     .child(
      //       '+91 62385 27898'.trim(),
      //     )
      //     .child(
      //       '8589960399',
      //     )
      //     .once()
      //     .then(
      //   ((value) {
      //      value.snapshot.value;
      //   }),
      // );

      emit(
        ChatState(
          chatData: state.chatData,
        ),
      );
    }

    on<SentMessage>(sentMessage);
    on<GetConversations>(getConversations);
  }
}
