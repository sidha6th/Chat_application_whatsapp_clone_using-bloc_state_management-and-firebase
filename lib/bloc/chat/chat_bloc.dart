import 'package:chat_app/extra/exports/exports.dart';
import 'package:chat_app/model/chats_model.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatState(chatData: [])) {
    sentMessage(SentMessage event, Emitter<ChatState> emit) async {
      ChatDetailsModel data = ChatDetailsModel(
        messageRecieverphoneNumber: event.phone,
        isSent: true,
        textMessage: event.message,
        messageRecieverName: event.name,
        time: event.time,
      );
      ChatState.textMsg.value = '';
      DatabaseReference reference = FirebaseDatabase.instance.ref();
      await reference
          .child('+91 62385 27898'.trim())
          .child('8589960399')
          .push()
          .set(data.toJson());
      state.chatData.add(data);
      emit(
        ChatState(chatData: state.chatData),
      );
    }

    getConversations(GetConversations event, Emitter<ChatState> emit) {
      '+91 62385 27898';
      // ignore: deprecated_member_use
      // data = FirebaseDatabase.instance.reference();
      // data.child(event.phone).onValue.listen(
      //   (events) {
      //     Map dat = events.snapshot.value;
      //   },
      // );
      //   FirebaseDatabase.instance
      //       .ref()
      //       .child('+91 62385 27898'.trim())
      //       .child('8589960399')
      //       .once()
      //       .then(((value) {
      //  //  var dat = Map<String, dynamic>.from(value.snapshot.value).;
      //   }));

      emit(ChatState(chatData: state.chatData));
    }

    on<SentMessage>(sentMessage);
    on<GetConversations>(getConversations);
  }
}
