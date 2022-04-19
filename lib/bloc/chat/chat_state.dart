part of 'chat_bloc.dart';

class ChatState {
  static String? userPhoneNumber;
  static final TextEditingController messageController =
      TextEditingController();
  static final ValueNotifier<String> textMsg = ValueNotifier('');
  List<ChatDetailsModel> chatData;
  ChatState({
    required this.chatData,
  });
}
