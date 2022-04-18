import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:chat_app/extra/exports/exports.dart';
import 'package:chat_app/model/group_model.dart';
import 'package:image_picker/image_picker.dart';

part 'group_event.dart';
part 'group_state.dart';

class GroupBloc extends Bloc<GroupEvent, GroupState> {
  GroupBloc()
      : super(GroupState(
          groupMembers: [],
          //userGroupList: [],
        )) {
    on<AddGroupMembers>(
      (AddGroupMembers event, Emitter<GroupState> emit) {
        bool repeated = false;
        for (var item in state.groupMembers) {
          if (item.memberPhoneNumber.trim() != event.phoneNumber.trim()) {
            repeated = false;
          } else {
            repeated = true;
            break;
          }
        }
        if (repeated == false) {
          GroupMembers instance = GroupMembers(
            memberPhoneNumber: event.phoneNumber,
            memberName: event.memberName,
          );
          state.groupMembers.add(
            instance,
          );
          emit(
            GroupState(
              //userGroupList: [],
              groupMembers: state.groupMembers,
            ),
          );
        }
      },
    );
    on<RemoveMember>(
      (RemoveMember event, Emitter<GroupState> emit) {
        state.groupMembers.removeAt(
          event.index,
        );
        emit(
          GroupState(
            groupMembers: state.groupMembers,
            //userGroupList: [],
          ),
        );
      },
    );
    on<CreateGroup>(
      (CreateGroup event, Emitter<GroupState> emit) {
        Group(
          members: state.groupMembers,
          groupName: state.groupNameController.text,
          groupDp: state.encodedGroupDp,
          groupId: DateTime.now().millisecondsSinceEpoch.toString(),
        );
      },
    );
    on<AddImage>(
      (AddImage event, Emitter<GroupState> emit) async {
        XFile? groupDp = await ImagePicker().pickImage(
          source: ImageSource.gallery,
        );
        if (groupDp != null) {
          debugPrint(
            'its dp ${groupDp.mimeType}',
          );
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
  }
}
