part of 'chat_bloc.dart';

class ChatState {
  static final ValueNotifier<String> textMsg=ValueNotifier('');
  List<ChatDetailsModel> chatData;
  ChatState({required this.chatData});
}
