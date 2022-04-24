import 'package:chat_app/extra/exports/exports.dart';
import 'package:chat_app/extra/service/firebase_services.dart';
import 'package:chat_app/extra/service/userdata.dart';
import 'package:chat_app/model/chats_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(const ChatState(conversation: [], chatsDone: [])) {
//*================================================================================*//
    addChatRoomForBothUser(SentMessage event) async {
      final UserAllChatsModel chatRoomforUser = UserAllChatsModel(
        conversationName: event.name,
        phoneNumber: event.receiverPhone,
        isGroup: false,
        chatRoomID: UserDataServices.getHashCode(
          '${event.receiverPhone.trim()}${ChatState.userPhoneNumber?.trim()}',
        ).toString(),
      );
      final UserAllChatsModel chatRoomforReciever = UserAllChatsModel(
        conversationName: FireBaseServices.userData![0].name,
        phoneNumber: ChatState.userPhoneNumber!,
        isGroup: false,
        chatRoomID: UserDataServices.getHashCode(
          '${event.receiverPhone.trim()}${ChatState.userPhoneNumber?.trim()}',
        ).toString(),
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
        DocumentReference<Map<String, dynamic>> doc;
        if (event.chatRoomId == null) {
          List<UserAllChatsModel> chatRoom =
              await FireBaseServices.checkIsThereAnyChatRoom(
            recieverPhoneNumber: event.receiverPhone,
            userPhoneNumber: ChatState.userPhoneNumber!,
          );
          if (chatRoom.isNotEmpty) {
            doc = FirebaseFirestore.instance
                .collection(chatRoom[0].chatRoomID)
                .doc();
            await doc.set(
              data.toJson(),
            );
          } else {
            await addChatRoomForBothUser(
              event,
            );
          }
        } else {
          doc = FirebaseFirestore.instance.collection(event.chatRoomId!).doc();
          await doc.set(
            data.toJson(),
          );
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
      QuerySnapshot<Map<String, dynamic>> data =
          await FirebaseFirestore.instance
              .collection(
                event.chatRoomId!,
              )
              .get();
      emit(
        ChatState(
          chatsDone: state.chatsDone,
          conversation: data.docs
              .map(
                (e) => IndividualChatModel.fromJson(
                  e.data(),
                ),
              )
              .toList(),
        ),
      );
    }

//*================================================================================*//

    getChatRooms(GetUserChatRooms event, Emitter<ChatState> emit) async {
      QuerySnapshot<Map<String, dynamic>> data =
          await FirebaseFirestore.instance
              .collection(
                ChatState.userPhoneNumber!,
              )
              .get();
      emit(
        ChatState(
          chatsDone: data.docs
              .map(
                (e) => UserAllChatsModel.fromJson(
                  e.data(),
                ),
              )
              .toList(),
          conversation: state.conversation,
        ),
      );
    }

    on<GetUserChatRooms>(getChatRooms);
    on<SentMessage>(sentMessage);
    on<GetConversations>(getConversations);
  }
}
