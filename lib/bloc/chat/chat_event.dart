part of 'chat_bloc.dart';

abstract class ChatEvent {}

class SentMessage extends ChatEvent {
  String receiverPhone;
  String name;
  bool isSent;
  String message;
  DateTime time;
  String? chatRoomId;
  SentMessage({
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
  String? chatRoomId;
  GetConversations({
    this.chatRoomId,
    required this.phone,
  });
}

class GetUserChatRooms extends ChatEvent {}
