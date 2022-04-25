part of 'group_bloc.dart';

class GroupState {
  final TextEditingController groupNameController = TextEditingController();
  List<GroupMembersModel> groupMembers;
  String? encodedGroupDp;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  //List<UserGroupModel> userGroupList;
  GroupState({
    required this.groupMembers,
    this.encodedGroupDp,
    //required this.userGroupList,
  });
}
