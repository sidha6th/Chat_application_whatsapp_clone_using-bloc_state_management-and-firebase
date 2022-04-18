part of 'profile_bloc.dart';

class ProfileEvent {}

class AddDpImage extends ProfileEvent {}

class SaveUserDatas extends ProfileEvent {
  final String userName;
  String? userAbout;
  SaveUserDatas({
    required this.userName,
    this.userAbout='',
  });
}
