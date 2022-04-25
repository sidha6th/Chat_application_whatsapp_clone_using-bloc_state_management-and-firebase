part of 'group_bloc.dart';

class GroupEvent {}

class AddGroupMembers extends GroupEvent {
  final String memberName;
  final String phoneNumber;
  final String? photo;
  AddGroupMembers({
    required this.memberName,
    required this.phoneNumber,
    this.photo,
  });
}

class RemoveMember extends GroupEvent {
  final int index;
  RemoveMember({
    required this.index,
  });
}

class AddImage extends GroupEvent {}

class CreateGroup extends GroupEvent {
  final BuildContext context;
  CreateGroup({required this.context});
}
