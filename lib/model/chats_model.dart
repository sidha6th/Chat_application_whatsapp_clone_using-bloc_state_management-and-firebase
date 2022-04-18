enum messageType {
  sent,
  receive,
}

class ChatDetailsModel {
  final String? messageRecieverName;
  final String messageRecieverphoneNumber;
  final String textMessage;
  final bool isSent;
  String? key;
  final dynamic photo;
  final DateTime time;
  ChatDetailsModel({
    required this.time,
    required this.textMessage,
    required this.isSent,
    required this.messageRecieverphoneNumber,
    this.messageRecieverName,
    this.photo,
    this.key,
  });

  Map<String, dynamic> toJson() => {
        'messageRecieverName': messageRecieverName,
        'messageRecieverphoneNumber': messageRecieverphoneNumber,
        'textMessage': textMessage,
        'time': time.toString(),
        'isSent': isSent,
        'photo': photo,
        'key': key,
      };

  static ChatDetailsModel fromJson(Map<String, dynamic> json) {
    return ChatDetailsModel(
      textMessage: json['textMessage'],
      isSent: json['isSent'],
      time: json['time'],
      messageRecieverphoneNumber: json['messageRecieverphoneNumber'],
    );
  }
}
