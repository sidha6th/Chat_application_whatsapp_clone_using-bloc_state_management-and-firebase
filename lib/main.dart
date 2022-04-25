import 'package:chat_app/bloc/chat/chat_bloc.dart';
import 'package:chat_app/bloc/group/group_bloc.dart';
import 'package:chat_app/bloc/login/login_bloc.dart';
import 'package:chat_app/bloc/profile/profile_bloc.dart';
import 'package:chat_app/bloc/splash/splash_bloc.dart';
import 'package:chat_app/extra/exports/exports.dart';
import 'package:chat_app/extra/service/firebase_services.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FireBaseServices.getUserData();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeBloc(),
        ),
        BlocProvider(
          create: (context) => ChatBloc(),
        ),
        BlocProvider(
          create: (context) => LoginBloc(),
        ),
        BlocProvider(
          create: (context) => ProfileBloc(),
        ),
        BlocProvider(
          create: (context) => SplashBloc(),
        ),
        BlocProvider(
          create: (context) => GroupBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ChatZ',
        theme: ThemeData(
          fontFamily: 'Default',
          primarySwatch: Colors.blueGrey,
          primaryColorDark: Colors.black,
          primaryColorLight: Colors.white,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
