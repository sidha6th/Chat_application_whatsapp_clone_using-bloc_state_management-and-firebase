import 'package:chat_app/bloc/chat/chat_bloc.dart';
import 'package:chat_app/bloc/group/group_bloc.dart';
import 'package:chat_app/model/chats_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupServices {
  //*========= Checking the user is already added or not to the group =========*//

  static bool checkIsAlreadyAddedOrNot(
      {required GroupState state, required AddGroupMembers event}) {
    bool repeated = false;
    for (var item in state.groupMembers) {
      if (item.memberPhoneNumber.trim() != event.phoneNumber.trim()) {
        repeated = false;
      } else {
        repeated = true;
        break;
      }
    }
    return repeated;
  }

  //*========= Checking the user is already added or not to the group =========*//

  //*================ Adding Group Chat Room to all user Mobile Numbers ================*//

  static addGroupRoomToAllMembers(
      {required String phoneNumber,
      required String roomId,
      required UserAllChatsModel object}) async {
    await FirebaseFirestore.instance
        .collection(phoneNumber)
        .doc(roomId)
        .set(object.toJson());
  }

  static Stream<List<UserAllChatsModel>> getUserChatRooms(
      {required BuildContext context}) async* {
    BlocProvider.of<ChatBloc>(context).add(GetUserChatRooms());
     yield await FirebaseFirestore.instance
        .collection(ChatState.userPhoneNumber!)
        .get()
        .then((value) => value.docs
            .map((e) => UserAllChatsModel.fromJson(e.data()))
            .toList());
  }

  //*================ Adding Group Chat Room to all user Mobile Numbers ================*//

}
