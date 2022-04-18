part of 'chat_bloc.dart';

abstract class ChatEvent {}

class SentMessage extends ChatEvent {
  String name;
  String phone;
  bool isSent;
  String message;
  DateTime time;
  SentMessage({
    required this.time,
    required this.name,
    required this.phone,
    required this.isSent,
    required this.message,
  });
}

class GetConversations extends ChatEvent {
  String phone;
  GetConversations({
    required this.phone,
  });
}
