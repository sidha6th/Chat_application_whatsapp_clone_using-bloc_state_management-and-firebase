part of 'profile_bloc.dart';

class ProfileState {
   String? encodededImg;
  ProfileState({this.encodededImg});
  static const String dpImageKey = 'DpImage';
  static final TextEditingController usernameController =
      TextEditingController();
  static final TextEditingController aboutFieldController =
      TextEditingController();
  static final GlobalKey<FormState> profileFormKey = GlobalKey<FormState>();
}

class AddPhoto extends ProfileState {
  AddPhoto();
}
