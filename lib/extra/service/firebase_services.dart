import 'package:chat_app/bloc/chat/chat_bloc.dart';
import 'package:chat_app/extra/exports/exports.dart';
import 'package:chat_app/extra/service/user_service.dart';
import 'package:chat_app/model/chats_model.dart';
import 'package:chat_app/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireBaseServices {
  static List<UserModel>? userData;

  //*====== getting only the current user datas ======*//

  static getUserData() async {
    await UserDataServices.getPhoneNumber();
    if (ChatState.userPhoneNumber != null) {
      QuerySnapshot<Map<String, dynamic>> data = await FirebaseFirestore
          .instance
          .collection('users')
          .where(ChatState.userPhoneNumber!)
          .get();

      userData = data.docs
          .map((snapshot) => UserModel.fromJson(snapshot.data()))
          .toList();
    }
  }

  //*====== getting only the current user datas ======*//

  //*====== getting whole users from the database ======*//

  static getAllUsers() async {
    QuerySnapshot<Map<String, dynamic>> users =
        await FirebaseFirestore.instance.collection('users').get();
    HomeState.allUsers =
        users.docs.map((e) => UserModel.fromJson(e.data())).toList();
  }

  //*====== getting whole users from the database ======*//

  //*====== Creating Chat Room for the first chat ======*//

  static createChatRoom(
      {required String phoneNumberOne,
      required UserAllChatsModel chatRoom,
      required String phoneNumberTwo}) async {
    await FirebaseFirestore.instance
        .collection(phoneNumberOne)
        .doc(phoneNumberTwo)
        .set(
          chatRoom.toJson(),
        );
  }

  //*====== Creating Chat Room for the first chat ======*//

  //*====== Checking is there already chat room created or not ======*//

  static Future<UserAllChatsModel?> checkIsThereAnyChatRoom(
      {required String userPhoneNumber,
      required String recieverPhoneNumber}) async {
    DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection(userPhoneNumber)
        .doc(recieverPhoneNumber)
        .get();
    return snapshot.data() == null
        ? null
        : UserAllChatsModel.fromJson(snapshot.data()!);
  }

  //*====== Checking is there already chat room created or not ======*//
}
