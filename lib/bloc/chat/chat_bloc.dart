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

    UserAllChatsModel? object;
    sentMessage(SentMessage event, Emitter<ChatState> emit) async {
      if (ChatState.userPhoneNumber == null) {
        await UserDataServices.getPhoneNumber();
      }
      ChatState.textMsg.value = '';
      if (ChatState.userPhoneNumber != null) {
        // print(ChatState.userPhoneNumber);
        final IndividualChatModel chatData = IndividualChatModel(
          messageSentName: event.userNumber,
          messageSentNumber: event.userNumber,
          conversationKey: DateTime.now().millisecondsSinceEpoch.toString(),
          messageRecieverphoneNumber: event.receiverPhone,
          textMessage: event.message,
          messageRecieverName: event.name,
          time: event.time,
        );
        if (event.isGroup) {
          await FirebaseFirestore.instance
              .collection(event.chatRoomId)
              .doc()
              .set(chatData.toJson());
        } else {
          if (event.chatRoomId.trim().isEmpty) {
            object = await FireBaseServices.checkIsThereAnyChatRoom(
              recieverPhoneNumber: event.receiverPhone,
              userPhoneNumber: ChatState.userPhoneNumber!,
            );
            if (object != null) {
              await FirebaseFirestore.instance
                  .collection(object!.chatRoomID)
                  .doc()
                  .set(chatData.toJson());
            } else {
              String chatRoomId = UserDataServices.getHashCode(
                '${event.receiverPhone.trim()}${ChatState.userPhoneNumber?.trim()}',
              );
              await addChatRoomForBothUser(event, chatRoomId: chatRoomId);
              await FirebaseFirestore.instance
                  .collection(chatRoomId)
                  .doc()
                  .set(chatData.toJson());
            }
          } else {
            await FirebaseFirestore.instance
                .collection(event.chatRoomId)
                .doc()
                .set(chatData.toJson());
          }
        }
      }
    }

//*================================================================================*//

    getConversations(GetConversations event, Emitter<ChatState> emit) async {
      emit(ChatState(
          chatsDone: state.chatsDone,
          conversation: await FirebaseFirestore.instance
              .collection((event.chatRoomId.isEmpty)
                  ? object!.chatRoomID
                  : event.chatRoomId)
              .orderBy('time')
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
      if (event.snapshotData != null) {
        emit(
          ChatState(
            chatsDone: event.snapshotData!,
            conversation: state.conversation,
          ),
        );
      } else {
        emit(
          ChatState(
            chatsDone: state.chatsDone,
            conversation: state.conversation,
          ),
        );
      }
    }

    on<GetUserChatRooms>(getChatRooms);
    on<SentMessage>(sentMessage);
    on<GetConversations>(getConversations);
  }
}
