class GroupMembers {
  final String memberPhoneNumber;
  final String memberName;

  GroupMembers({
    required this.memberPhoneNumber,
    required this.memberName,
  });
}

class Group {
  String? groupDp;
  String? groupId;
  final String groupName;
  final List<GroupMembers> members;
  Group({
    required this.members,
    required this.groupName,
    this.groupDp,
    this.groupId,
  });
}
