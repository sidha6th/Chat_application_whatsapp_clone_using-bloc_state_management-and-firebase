import 'package:chat_app/bloc/chat/chat_bloc.dart';
import 'package:chat_app/extra/exports/exports.dart';
import 'package:chat_app/bloc/login/login_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDataServices {
  static String? honeNumber;

  //*==== Getting PhoneNumber from Sharedpreference ====*//
  static Future<void> getPhoneNumber() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    ChatState.userPhoneNumber = pref.getString(LoginState.phoneNumberKey);
  }
  //*==== Getting PhoneNumber from Sharedpreference ====*//

  //*==== Removes special characters from the Phone Numbers ====*//
  static String removeSpecialChar(String data) =>
      data.toString().replaceAll(RegExp(r"[^\s\w]"), '').replaceAll(' ', '');
  //*==== Removes special characters from the Phone Numbers ====*//

  //*======= Generates hashcode for the chat room id =======*//
  static String getHashCode(String numbers) =>
      numbers.trim().hashCode.toString();
  //*======= Generates hashcode for the chat room id =======*//

  //*===== Getting Contact Details from the mobile devices =====*//
  static Future<List<Contact>> getContacts() => ContactsService.getContacts();
  //*===== Getting Contact Details from the mobile devices =====*//

  //*===== Formates the Date And Time =====*//
  static String getDateFormate({required DateTime time}) =>
      '${time.hour > 12 ? time.hour - 12 : time.hour}:${time.minute < 10 ? '0${time.minute}' : '${time.minute}'} ${time.hour > 12 ? 'pm' : 'am'}';
  //*===== Formates the Date And Time =====*//
}
