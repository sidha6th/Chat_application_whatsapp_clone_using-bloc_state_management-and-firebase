part of 'home_bloc.dart';

class HomeState {
  ScrollController scrollController = ScrollController(
    initialScrollOffset: 0,
  );
  final bool isGranted;
  final bool isDenied;
  final List<UserAllChatsModel> chatsDone;
  List<ContactsModel> contacts;
  static List<UserModel> allUsers=[];
  HomeState({
    required this.chatsDone,
    required this.contacts,
    this.isDenied = false,
    this.isGranted = false,
  });
}
