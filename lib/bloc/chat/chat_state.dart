part of 'chat_bloc.dart';

class ChatState extends Equatable {
  static String? userPhoneNumber;
  static final TextEditingController messageController =
      TextEditingController();
  static final ValueNotifier<String> textMsg = ValueNotifier('');
  final List<IndividualChatModel> conversation;
  final List<UserAllChatsModel> chatsDone;
  const ChatState({
    required this.chatsDone,
    required this.conversation,
  });

  @override
  List<Object?> get props =>conversation;
}
