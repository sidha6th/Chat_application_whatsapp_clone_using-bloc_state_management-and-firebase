import 'package:chat_app/bloc/chat/chat_bloc.dart';
import 'package:chat_app/extra/exports/exports.dart';
import 'package:chat_app/extra/service/group_services.dart';
import 'package:chat_app/model/chats_model.dart';
import 'package:chat_app/model/group_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
part 'group_event.dart';
part 'group_state.dart';

class GroupBloc extends Bloc<GroupEvent, GroupState> {
  GroupBloc() : super(GroupState(groupMembers: [])) {
    //*=======================================================*//

    on<AddGroupMembers>(
      (AddGroupMembers event, Emitter<GroupState> emit) {
        if (GroupServices.checkIsAlreadyAddedOrNot(
                event: event, state: state) ==
            false) {
          GroupMembersModel instance = GroupMembersModel(
            memberPhoneNumber: event.phoneNumber,
            memberName: event.memberName,
          );
          state.groupMembers.add(instance);
          emit(
            GroupState(groupMembers: state.groupMembers),
          );
        }
      },
    );

    //*=======================================================*//

    on<RemoveMember>(
      (RemoveMember event, Emitter<GroupState> emit) {
        state.groupMembers.removeAt(event.index);
        emit(
          GroupState(groupMembers: state.groupMembers),
        );
      },
    );

    //*=======================================================*//

    on<AddImage>(
      (AddImage event, Emitter<GroupState> emit) async {
        XFile? groupDp =
            await ImagePicker().pickImage(source: ImageSource.gallery);
        if (groupDp != null) {
          Uint8List dp = File(groupDp.path).readAsBytesSync();
          groupDp = null;
          state.encodedGroupDp = base64Encode(dp);
          emit(
            GroupState(
              groupMembers: state.groupMembers,
              encodedGroupDp: state.encodedGroupDp,
            ),
          );
        }
      },
    );

    //*=======================================================*//

    on<CreateGroup>(
      (CreateGroup event, Emitter<GroupState> emit) async {
        List<Map<String, dynamic>> temp = [];
        for (var item in state.groupMembers) {
          temp.add(item.toJson());
        }
        final UserAllChatsModel allChatsModel = UserAllChatsModel(
          phoneNumber: ChatState.userPhoneNumber!,
          conversationName: state.groupNameController.text,
          isGroup: true,
          chatRoomID: DateTime.now().millisecondsSinceEpoch.toString(),
          members: temp,
        );

        await FirebaseFirestore.instance
            .collection(allChatsModel.chatRoomID)
            .doc()
            .set(allChatsModel.toJson());

        //*============== Adding group creater to the group ============*//

        await FirebaseFirestore.instance
            .collection(ChatState.userPhoneNumber!)
            .doc(allChatsModel.chatRoomID)
            .set(allChatsModel.toJson());

        //*============== Adding group creater to the group ============*//

        //*============== Adding group members to the group ============*//

        for (var item in state.groupMembers) {
          await GroupServices.addGroupRoomToAllMembers(
            phoneNumber: item.memberPhoneNumber,
            roomId: allChatsModel.chatRoomID,
            object: allChatsModel,
          );
        }

             //event.context.read<ChatBloc>().add(GetUserChatRooms());
        //*============== Adding group members to the group ============*//
      },
    );
    //*=======================================================*//
  }
}
