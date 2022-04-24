import 'package:chat_app/bloc/chat/chat_bloc.dart';
import 'package:chat_app/extra/exports/exports.dart';
import 'package:chat_app/bloc/login/login_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDataServices {
  static String? honeNumber;

  //*==== Getting PhoneNumber from Sharedpreference ====*//
  static getPhoneNumber() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
     ChatState.userPhoneNumber = pref.getString(LoginState.phoneNumberKey);
  }
  //*==== Getting PhoneNumber from Sharedpreference ====*//

  //*==== Removes special characters from the Phone Numbers ====*//
  static String removeSpecialChar(String data) =>
      data.toString().replaceAll(RegExp(r"[^\s\w]"), '').replaceAll(' ', '');
  //*==== Removes special characters from the Phone Numbers ====*//

  //*======= Generates hashcode for the chat room id =======*//
  static int getHashCode(String numbers) => numbers.trim().hashCode;
  //*======= Generates hashcode for the chat room id =======*//

  //*===== Getting Contact Details from the mobile devices =====*//
  static Future<List<Contact>> getContacts() => ContactsService.getContacts();
  //*===== Getting Contact Details from the mobile devices =====*//
}
