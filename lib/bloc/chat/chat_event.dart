part of 'chat_bloc.dart';

abstract class ChatEvent {}

class SentMessage extends ChatEvent {
  String receiverPhone;
  String name;
  bool isSent;
  String message;
  DateTime time;
  String chatRoomId;
  final bool isGroup;
  final String userNumber;
  SentMessage({
    required this.userNumber,
    required this.isGroup,
    required this.chatRoomId,
    required this.time,
    required this.name,
    required this.receiverPhone,
    required this.isSent,
    required this.message,
  });
}

class GetConversations extends ChatEvent {
  String phone;
  final String chatRoomId;
  final bool isGroup;
  GetConversations({
    required this.chatRoomId,
    required this.isGroup,
    required this.phone,
  });
}

class GetUserChatRooms extends ChatEvent {
  final List<UserAllChatsModel>? snapshotData;
  GetUserChatRooms({this.snapshotData});
}
