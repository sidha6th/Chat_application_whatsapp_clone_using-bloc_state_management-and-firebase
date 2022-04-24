part of 'login_bloc.dart';

class LoginState {
  static final otpTextController = TextEditingController();
  static final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  String? phone;
  static String? userId;
  static String isLoginedKey ='isLoginedKey';
  static const String phoneNumberKey = 'phone';
  static SharedPreferences? prefs;
  User? user;
  String? loginException;
  PhoneAuthCredential? credential;
  FirebaseAuth auth = FirebaseAuth.instance;
  List<String> codes = [];
  String? verificationId;
  int? token;
  static final TextEditingController loginPhoneNumberController =
      TextEditingController(text: '');
  static final TextEditingController countryCodeController =
      TextEditingController(text: '');

  static String? value;
  static int? index;
  static const List<String> country = [
    'Choose a country',
    'United States',
    'India',
    'Kenya',
    'South Africa',
  ];
  static const List<String> contryCode = ['', '+1', '+91', '+254', '+27'];
}

class LoginInitial extends LoginState {}

class FirebaseLoginState extends LoginState {}
