import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:chat_app/bloc/login/login_bloc.dart';
import 'package:chat_app/extra/exports/exports.dart';
import 'package:chat_app/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileState()) {
    addDpImage(AddDpImage event, Emitter<ProfileState> emit) async {
      XFile? image;
      image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );
      if (image != null) {
        Uint8List bytesimg = File(
          image.path,
        ).readAsBytesSync();
        image = null;
        state.encodededImg = base64Encode(
          bytesimg,
        );
        // LoginState.prefs = await SharedPreferences.getInstance();
        // await LoginState.prefs?.setString(
        //   ProfileState.dpImageKey,
        //   state.encodededImg!,
        // );
        emit(
          ProfileState(
            encodededImg: state.encodededImg,
          ),
        );
      }
    }

    saveUserDatas(SaveUserDatas event, Emitter<ProfileState> emit) async {
      UserModel data = UserModel(
        id: LoginState.userId,
        name: event.userName,
        phone:
            '${LoginState.countryCodeController.text}${LoginState.loginPhoneNumberController.text}',
        about: event.userAbout,
        dpImage: state.encodededImg,
      );
      final DocumentReference<Map<String, dynamic>> doc =
          FirebaseFirestore.instance
              .collection(
                'users'
              )
              .doc(
                '${LoginState.countryCodeController.text}${LoginState.loginPhoneNumberController.text}',
              );
      try {
        await doc.set(
          data.toJson(),
        );
      } on FirebaseException catch (e) {
        debugPrint(
          e.message,
        );
        debugPrint(
          '${e.stackTrace}',
        );
        debugPrint(
          e.plugin,
        );
      }
      //
      LoginState.prefs = await SharedPreferences.getInstance();
      await LoginState.prefs?.setBool(
        LoginState.isLoginedKey,
        true,
      );
      //
    }

    on<AddDpImage>(
      addDpImage,
    );
    on<SaveUserDatas>(
      saveUserDatas,
    );
  }
}
