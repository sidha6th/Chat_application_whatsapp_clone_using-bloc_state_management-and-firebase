part of 'chat_bloc.dart';

class ChatState{
  static String? userPhoneNumber;
  static final TextEditingController messageController =
      TextEditingController();
  static final ValueNotifier<String> textMsg = ValueNotifier('');
  final List<IndividualChatModel> conversation;
  List<UserAllChatsModel> chatsDone;
   ChatState({
    required this.chatsDone,
    required this.conversation,
  });

}
