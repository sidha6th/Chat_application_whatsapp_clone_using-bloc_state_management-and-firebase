class IndividualChatModel {
  final String? messageRecieverName;
  final String messageSentNumber;
  final String? messageSentName;
  final String? messageRecieverphoneNumber;
  final String textMessage;
  final String? conversationKey;
  final dynamic photo;
  final DateTime time;
  IndividualChatModel({
    required this.time,
    required this.messageRecieverName,
    required this.messageSentName,
    required this.messageSentNumber,
    required this.textMessage,
    required this.messageRecieverphoneNumber,
    required this.conversationKey,
    this.photo,
  });

  Map<String, dynamic> toJson() => {
        'messageRecieverName': messageRecieverName,
        'messageRecieverphoneNumber': messageRecieverphoneNumber,
        'textMessage': textMessage,
        'conversationKey':conversationKey,
        'messageSentName':messageSentName,
        'messageSentNumber':messageSentNumber,
        'time': time.toUtc(),
        'photo': photo,
      };

  static IndividualChatModel fromJson(Map<String, dynamic> json) {
    return IndividualChatModel(
      messageSentName: json['messageSentName'],
      messageSentNumber: json['messageSentNumber'],
      conversationKey: json['conversationKey'],
      messageRecieverName: json['messageRecieverName'],
      photo: json['photo'],
      textMessage: json['textMessage'],
      time: json['time'].toDate(),
      messageRecieverphoneNumber: json['messageRecieverphoneNumber'],
    );
  }
}

class UserAllChatsModel {
  final String conversationName;
  final String phoneNumber;
  final bool isGroup;
  final String chatRoomID;
  String? conversationDp;
  List<Map<String, dynamic>>? members;
  UserAllChatsModel({
    required this.phoneNumber,
    required this.conversationName,
    required this.isGroup,
    required this.chatRoomID,
    this.conversationDp,
    this.members,
  });
  Map<String, dynamic> toJson() => {
        'phoneNumber': phoneNumber,
        'conversationName': conversationName,
        'isGroup': isGroup,
        'chatRoomID': chatRoomID,
        'conversationDp': conversationDp,
      };
  static UserAllChatsModel fromJson(Map<String, dynamic> json) =>
      UserAllChatsModel(
        phoneNumber: json['phoneNumber'],
        conversationName: json['conversationName'],
        isGroup: json['isGroup'],
        chatRoomID: json['chatRoomID'],
        conversationDp: json['conversationDp'],
      );
}
