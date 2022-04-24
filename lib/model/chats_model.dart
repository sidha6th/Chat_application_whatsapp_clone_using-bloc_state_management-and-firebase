// enum messageType {
//   sent,
//   receive,
// }

class IndividualChatModel {
  final String? messageRecieverName;
  final String messageRecieverphoneNumber;
  final String textMessage;
  final String msgSentNumber;
  final String? conversationKey;
  final dynamic photo;
  final DateTime? time;
  IndividualChatModel({
     this.time,
    required this.textMessage,
    required this.msgSentNumber,
    required this.messageRecieverphoneNumber,
    required this.conversationKey,
    this.messageRecieverName,
    this.photo,
  });

  Map<String, dynamic> toJson() => {
        'msgSentNumber': msgSentNumber,
        'messageRecieverName': messageRecieverName,
        'messageRecieverphoneNumber': messageRecieverphoneNumber,
        'textMessage': textMessage,
        'time': time,
        'photo': photo,
        'key': conversationKey,
      };

  static IndividualChatModel fromJson(Map<String, dynamic> json) {
    return IndividualChatModel(
      conversationKey: json['conversationKey'],
      messageRecieverName: json['messageRecieverName'],
      photo: json['photo'],
      msgSentNumber: json['msgSentNumber'],
      textMessage: json['textMessage'],
      //time: json['time'],
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
  UserAllChatsModel({
    required this.phoneNumber,
    required this.conversationName,
    required this.isGroup,
    required this.chatRoomID,
    this.conversationDp,
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
