part of 'home_bloc.dart';

class HomeState {
  ScrollController scrollController = ScrollController();
  bool isGranted = false;
  final List<ChatDetailsModel> chatsDone;
  List<Contact> contacts;
  HomeState({
    required this.chatsDone,
    required this.contacts,
  });
}
