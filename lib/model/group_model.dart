class GroupMembersModel {
  final String memberPhoneNumber;
  final String memberName;
  final String? dP;

  GroupMembersModel({
    this.dP,
    required this.memberPhoneNumber,
    required this.memberName,
  });
  Map<String, dynamic> toJson() => {
        'memberPhoneNumber': memberPhoneNumber,
        'memberName': memberName,
        'dP': dP,
      };
  static GroupMembersModel fromJson(Map<String, dynamic> json) =>
      GroupMembersModel(
        dP: json['dP'],
        memberPhoneNumber: json['memberPhoneNumber'],
        memberName: json['memberName'],
      );
}

class Group {
  String? groupDp;
  final String groupId;
  final String groupName;
  Group({
    required this.groupName,
    this.groupDp,
    required this.groupId,
  });

  Map<String, dynamic> toJson() => {
        'groupName': groupName,
        'groupId': groupId,
        'groupDp': groupDp,
      };

  static Group fromJson(Map<String, dynamic> json) => Group(
        groupName: json['groupName'],
        groupId: json['groupId'],
      );
}




