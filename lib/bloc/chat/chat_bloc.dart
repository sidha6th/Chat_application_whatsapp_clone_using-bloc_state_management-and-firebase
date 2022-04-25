import 'package:chat_app/extra/exports/exports.dart';
import 'package:chat_app/extra/service/firebase_services.dart';
import 'package:chat_app/extra/service/user_service.dart';
import 'package:chat_app/model/chats_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatState(conversation: const [], chatsDone: const [])) {
//*================================================================================*//
    addChatRoomForBothUser(SentMessage event,
        {required String chatRoomId}) async {
      final UserAllChatsModel chatRoomforUser = UserAllChatsModel(
        conversationName: event.name,
        phoneNumber: event.receiverPhone,
        isGroup: false,
        chatRoomID: chatRoomId,
      );
      final UserAllChatsModel chatRoomforReciever = UserAllChatsModel(
        conversationName: FireBaseServices.userData![0].name,
        phoneNumber: ChatState.userPhoneNumber!,
        isGroup: false,
        chatRoomID: chatRoomId,
      );

      await FireBaseServices.createChatRoom(
        chatRoom: chatRoomforReciever,
        phoneNumberTwo: ChatState.userPhoneNumber!,
        phoneNumberOne: event.receiverPhone,
      );
      await FireBaseServices.createChatRoom(
        chatRoom: chatRoomforUser,
        phoneNumberTwo: event.receiverPhone,
        phoneNumberOne: ChatState.userPhoneNumber!,
      );
    }

    late List<UserAllChatsModel> chatRoom;
    sentMessage(SentMessage event, Emitter<ChatState> emit) async {
      if (ChatState.userPhoneNumber == null) {
        await UserDataServices.getPhoneNumber();
      }
      ChatState.textMsg.value = '';
      if (ChatState.userPhoneNumber != null) {
        final IndividualChatModel data = IndividualChatModel(
          conversationKey: ChatState.userPhoneNumber,
          msgSentNumber: ChatState.userPhoneNumber!,
          messageRecieverphoneNumber: event.receiverPhone,
          textMessage: event.message,
          messageRecieverName: event.name,
          // time: event.time,
        );
        if (event.chatRoomId.trim().isEmpty) {
          chatRoom = await FireBaseServices.checkIsThereAnyChatRoom(
            recieverPhoneNumber: event.receiverPhone,
            userPhoneNumber: ChatState.userPhoneNumber!,
          );
          if (chatRoom.isNotEmpty) {
            event.chatRoomId = chatRoom[0].chatRoomID;
            await FirebaseFirestore.instance
                .collection(chatRoom[0].chatRoomID)
                .doc()
                .set(data.toJson());
          } else {
            String chatRoomId = UserDataServices.getHashCode(
              '${event.receiverPhone.trim()}${ChatState.userPhoneNumber?.trim()}',
            );
            await addChatRoomForBothUser(event, chatRoomId: chatRoomId);
          }
        } else {
          await FirebaseFirestore.instance
              .collection(event.chatRoomId)
              .doc()
              .set(data.toJson());
        }
      }
      emit(
        ChatState(
          conversation: state.conversation,
          chatsDone: state.chatsDone,
        ),
      );
    }

//*================================================================================*//

    getConversations(GetConversations event, Emitter<ChatState> emit) async {
      // print(await FirebaseFirestore.instance
      //     .collection(
      //       event.chatRoomId.isEmpty
      //           ? chatRoom[0].chatRoomID
      //           : event.chatRoomId,
      //     )
      //     .get()
      //     .then((value) => value.docs
      //         .map((e) => IndividualChatModel.fromJson(e.data()))
      //         .toList()));
      for (var item in await FirebaseFirestore.instance
          .collection((event.chatRoomId.isEmpty)
              ? chatRoom[0].chatRoomID
              : event.chatRoomId)
          .get()
          .then((value) => value.docs
              .map((e) => IndividualChatModel.fromJson(e.data()))
              .toList())) {
        print(item.msgSentNumber);
      }

      emit(ChatState(
          chatsDone: state.chatsDone,
          conversation: await FirebaseFirestore.instance
              .collection((event.chatRoomId.isEmpty)
                  ? chatRoom[0].chatRoomID
                  : event.chatRoomId)
              .get()
              .then((value) => value.docs
                  .map((e) => IndividualChatModel.fromJson(e.data()))
                  .toList())));
    }

//*================================================================================*//

    getChatRooms(GetUserChatRooms event, Emitter<ChatState> emit) async {
      state.chatsDone = await FirebaseFirestore.instance
          .collection(ChatState.userPhoneNumber!)
          .get()
          .then((value) => value.docs
              .map((e) => UserAllChatsModel.fromJson(e.data()))
              .toList());
      emit(
        ChatState(
          chatsDone: state.chatsDone,
          conversation: state.conversation,
        ),
      );
    }

    on<GetUserChatRooms>(getChatRooms);
    on<SentMessage>(sentMessage);
    on<GetConversations>(getConversations);
  }
}
